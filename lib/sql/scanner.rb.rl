%%{
  # TODO: extract machine into separate rl file (minus ruby variable config)
  machine sql;

  k_true  = 'TRUE';
  k_false = 'FALSE';
  k_null  = 'NULL';

  action mark               { mark();              }
  action emit_identifier    { emit('identifier');  }
  action emit_select        { emit('select');      }
  action emit_from          { emit('from');        }
  action emit_end           { emit('end');         }
  action call_nested_select { fcall nested_select; }
  action return             { fret;                }

  identifier_part = '"' (alpha (alnum | '""')*) '"';
  identifier      = (identifier_part ('.' identifier_part)*)
                    >mark @emit_identifier;

  alias  = ' ' identifier;
  field  = identifier | k_true | k_false | k_null;
  fields = field (', ' field)*;

  from_clause   = 'FROM' @emit_from ' '
                  (identifier alias? | '(' >call_nested_select alias);

  select_clause = 'SELECT' @emit_select ' ' fields
                  (' ' from_clause)?;

  nested_select := select_clause ')' @emit_end @return;

  main := select_clause;

  # TODO: keep ruby specific variables inline while moving previous code
  variable data @buffer;
  variable p    @p;
  variable pe   self.pe;
  variable cs   @cs;
  variable top  @top;
}%%

module SQL
  class Scanner
    class InvalidInputError < StandardError

      def initialize(input)
        input.rewind
        super("Error tokenizing: #{input.read}")
      end

    end # InvalidInputError

    include Enumerable

    CHUNK_SIZE = 1  # XXX: 1 used for testing

    %% write data;

    def initialize(input)
      @input = input
      @block = @ts = nil
      @buffer = []
      %% write init;
    end

    def each(&block)
      return to_enum unless block
      return self if @block  # only allow one pass

      @block = block
      stack  = []

      # Tokenize a stream of input
      while chunk = read_chunk
        optimize_buffer
        @buffer.concat(chunk)
        %% write exec;
      end

      assert_valid_input

      self
    end

  protected

    def pe
      @buffer.length
    end

  private

    def mark
      @ts = @p
    end

    def emit(token)
      value = @buffer[@ts..@p] if @ts
      @block.call(token.to_sym, value)
      @ts = nil
    end

    def read_chunk
      chunk  = @input.read_nonblock(CHUNK_SIZE)
      format = chunk.encoding == Encoding::UTF_8 ? 'U*' : 'C*'
      chunk.unpack(format)
    rescue IO::WaitReadable
      IO.select([@input])
      retry
    rescue EOFError
      # return nil
    end

    def optimize_buffer
      if @ts.nil?
        clear_buffer
      elsif @ts.nonzero?
        truncate_buffer
      end
    end

    def clear_buffer
      @buffer.clear
      @p = 0
    end

    def truncate_buffer
      @buffer.slice!(0, @ts)
      @ts = 0
    end

    def assert_valid_input
      if @cs < sql_first_final
        fail InvalidInputError, @input
      end
    end

    # Delegate ragel reader methods to class readers
    (methods(false) | private_methods(false)).each do |method|
      next unless method =~ /\A_?sql_\w+\z/
      define_method(method) { self.class.send(method) }
    end

  end # Scanner
end # SQL
