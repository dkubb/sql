# encoding: utf-8

module SQL
  module Generator

    # Stream used to emit into
    class Stream

      # Return current output
      #
      # @return [#<<]
      #
      # @api private
      attr_reader :output

      # Initialize output stream
      #
      # @param [#<<] output
      #
      # @return [undefined]
      #
      # @api private
      def initialize(output = '')
        @output        = output
        @start_of_line = true
      end

      # Append string
      #
      # @param [String] string
      #
      # @return [self]
      #
      # @api private
      def <<(string)
        output << string
        @start_of_line = string.end_with?(Constants::NL)
        self
      end

      # Increase indent
      #
      # @return [self]
      #
      # @api private
      def indent
        Indented.new(self).nl
      end

      # Write newline
      #
      # @return [self]
      #
      # @api private
      def nl
        output << Constants::NL
        self
      end

    protected

      # Test if the stream is at the start of a line
      #
      # @return [Boolean]
      #
      # @api private
      def start_of_line?
        @start_of_line
      end

      # Indented Stream used to emit into
      class Indented < self
        DEFAULT_INDENT = '  '.freeze

        # Append string with indentation
        #
        # @param [String] _string
        #
        # @return [self]
        #
        # @api private
        def <<(_string)
          output << DEFAULT_INDENT if output.start_of_line?
          super
        end

        # Decrease indent
        #
        # @return [self]
        #
        # @api private
        def unindent
          output.nl
        end

      end # Indented
    end # Stream
  end # Generator
end # SQL
