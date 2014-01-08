%%{
  # TODO: extract machine into separate rl file (minus ruby variable config)
  machine sql;

  unsigned_integer = digit+;

  identifier_start = alpha | 0x80..0xff;
  identifier_part  = identifier_start | digit | '""';
  identifier_body  = identifier_start ('_'? identifier_part)*;
  identifier       = '"' identifier_body '"';

  main := |*
    space;

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
    'E'              { emit('E');           };

    unsigned_integer { emit_unsigned_integer(); };
    identifier       { emit_identifier();       };
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

#    CHUNK_SIZE = 1024
    CHUNK_SIZE = 1  # XXX: 1 used for testing

    %% write data;

    def initialize(input)
      @input = input
      @block = nil
      @buffer = []
      %% write init;
    end

    def each(&block)
      return to_enum unless block
      return self if @block  # only allow one pass
      @block = block

      # Tokenize a stream of input
      while chunk = read_chunk
        @buffer.concat(chunk)
        %% write exec;
        optimize_buffer
      end
      assert_valid_input
      self
    end

  protected

    def pe
      @buffer.length
    end

  private

    def emit(token, value = text)
      @block.call(token.to_sym, value)
      @ts = nil
    end

    def emit_unsigned_integer
      emit(:unsigned_integer, Integer(text))
    end

    def emit_identifier
      identifier = text
      identifier.gsub!(/\A"(.*)"\z/, '\1') and identifier.gsub!('""', '"')
      emit(:identifier, identifier)
    end

    def text
      @buffer[@ts...@te].pack('U*')
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
