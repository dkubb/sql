%%{
  # TODO: extract machine into separate rl file (minus ruby variable config)
  machine sql;

  delimiter        = 0;
  separator        = ' ' | "\r" | "\n";
  quote            = "'";
  double_quote     = '"';
  extended_ascii   = 0x80..0xff;
  underscore       = '_';

  quoted_string    = quote (^quote | quote{2})** quote;

  unsigned_integer = digit+;

  identifier_start = alpha | extended_ascii;
  identifier_part  = identifier_start | digit | double_quote{2};
  identifier_body  = identifier_start (underscore? identifier_part)*;
  identifier       = double_quote identifier_body double_quote;

  main := |*
    delimiter;
    separator;

    # Keywords
    'SELECT'         { emit('select'); };
    'FROM'           { emit('from');   };
    'AS'             { emit('as');     };

    # Literals
    'TRUE'           { emit('true');  };
    'FALSE'          { emit('false'); };
    'NULL'           { emit('null');  };

    # Operators
    '('              { emit('left_paren');  };
    ')'              { emit('right_paren'); };
    ','              { emit('comma');       };
    '.'              { emit('period');      };
    '+'              { emit('plus_sign');   };
    '-'              { emit('minus_sign');  };
    '*'              { emit('asterisk');    };
    '/'              { emit('solidus');     };
    '%'              { emit('mod');         };
    '^'              { emit('pow');         };
    'E'              { emit('E');           };

    quoted_string    { emit_string();           };
    unsigned_integer { emit_unsigned_integer(); };

    identifier       { emit_identifier(); };
  *|;

  # TODO: keep ruby specific variables inline while moving previous code
  access @;
  variable data @buffer;
  variable p    @p;
  variable pe   self.pe;
  variable eof  @eof;
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

#    CHUNK_SIZE  = 1024
    CHUNK_SIZE  = 1  # XXX: used for testing
    END_OF_FILE = [0].freeze

    %% write data;

    def initialize(input)
      @input    = input
      @encoding = @input.external_encoding
      @block    = nil
      @buffer   = []
      %% write init;
    end

    def each(&block)
      return to_enum unless block
      return self if @block  # only allow one pass
      @block = block
      scan_input
      self
    end

  protected

    def pe
      @buffer.length
    end

  private

    def scan_input
      begin
        chunk = read_chunk
        @buffer.concat(chunk)
        %% write exec;
        optimize_buffer
      end until chunk == END_OF_FILE
      assert_valid_input
    end

    def emit(token, value = text)
      @block.call(token.to_sym, value)
      @ts = nil
    end

    def emit_identifier
      identifier = text
      identifier.sub!(/\A"(.*)"\z/, '\1') and identifier.gsub!('""', '"')
      emit(:identifier, identifier)
    end

    def emit_unsigned_integer
      emit(:unsigned_integer, Integer(text))
    end

    def emit_string
      string = text
      string.sub!(/\A'(.*)'\z/, '\1') and string.gsub!("''", "'")
      emit(:string, string)
    end

    def text
      @buffer[@ts...@te].pack('C*').force_encoding(@encoding)
    end

    def read_chunk
      @input.read_nonblock(CHUNK_SIZE).bytes
    rescue IO::WaitReadable
      IO.select([@input])
      retry
    rescue EOFError
      END_OF_FILE
    end

    def optimize_buffer
      reset_buffer if @ts.nil?
    end

    def reset_buffer
      @buffer.clear
      @p = 0
    end

    def assert_valid_input
      if @cs < %%{ write first_final; }%%
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
