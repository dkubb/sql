module SQL
  module Generator

    # Emitter base class
    class Emitter
      include Adamantium::Flat, AbstractType

      # Registry for node emitters
      REGISTRY = {}

      CB_L           = '{'.freeze
      CB_R           = '}'.freeze
      CURLY_BRACKETS = [ CB_L, CB_R ].freeze

      PARENTHESES_L  = '('.freeze
      PARENTHESES_R  = ')'.freeze
      PARENTHESES    = [ PARENTHESES_L, PARENTHESES_R ].freeze

      WS = ' '.freeze
      NL = "\n".freeze

      # Keywords
      K_TRUE  = 'TRUE'.freeze
      K_FALSE = 'FALSE'.freeze
      K_NULL  = 'NULL'.freeze
      K_AND   = 'AND'.freeze
      K_OR    = 'OR'.freeze

      # Operators
      O_PLUS     = '+'.freeze
      O_MINUS    = '-'.freeze
      O_NEGATION = '!'.freeze

      # Delimiters
      D_QUOTE             = %q(').freeze
      D_ESCAPED_QUOTE     = %q('').freeze
      D_DBL_QUOTE         = %q(").freeze
      D_ESCAPED_DBL_QUOTE = %q("").freeze
      DEFAULT_DELIMITER   = ', '.freeze

      # Register emitter for type
      #
      # @param [Symbol] type
      #
      # @return [undefined]
      #
      # @api private
      #
      def self.handle(*types)
        types.each do |type|
          REGISTRY[type] = self
        end
      end
      private_class_method :handle

      # Emit node into buffer
      #
      # @return [self]
      #
      # @api private
      #
      def self.emit(*arguments)
        new(*arguments)
        self
      end

      # Initialize object
      #
      # @param [Parser::AST::Node] node
      # @param [Buffer] buffer
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(node, buffer)
        @node, @buffer = node, buffer
        dispatch
      end
      private_class_method :new

      # Visit node
      #
      # @param [Parser::AST::Node] node
      # @param [Buffer] buffer
      #
      # @return [Emitter]
      #
      # @api private
      #
      def self.visit(node, buffer)
        type = node.type
        emitter = REGISTRY.fetch(type) do
          raise ArgumentError, "No emitter for node: #{type.inspect}"
        end
        emitter.emit(node, buffer)
        self
      end

      # Return node
      #
      # @return [Parser::AST::Node] node
      #
      # @api private
      #
      attr_reader :node

      # Return buffer
      #
      # @return [Buffer] buffer
      #
      # @api private
      #
      attr_reader :buffer
      protected :buffer

    private

      # Emit contents of block within parentheses
      #
      # @return [undefined]
      #
      # @api private
      #
      def parentheses(left = PARENTHESES_L, right = PARENTHESES_R)
        write(left)
        yield
        write(right)
      end

      # Dispatch helper
      #
      # @param [Parser::AST::Node] node
      #
      # @return [undefined]
      #
      # @api private
      #
      def visit(node)
        self.class.visit(node, buffer)
      end

      # Emit delimited body
      #
      # @param [Enumerable<Parser::AST::Node>] nodes
      # @param [String] delimiter
      #
      # @return [undefined]
      #
      # @api private
      #
      def delimited(nodes, delimiter = DEFAULT_DELIMITER)
        max = nodes.length - 1
        nodes.each_with_index do |node, index|
          visit(node)
          write(delimiter) if index < max
        end
      end

      # Return children of node
      #
      # @return [Array<Parser::AST::Node>]
      #
      # @api private
      #
      def children
        node.children
      end

      # Write newline
      #
      # @return [undefined]
      #
      # @api private
      #
      def nl
        buffer.nl
      end

      # Write strings into buffer
      #
      # @return [undefined]
      #
      # @api private
      #
      def write(*strings)
        strings.each do |string|
          buffer.append(string)
        end
      end

      # Return first child
      #
      # @return [Parser::AST::Node]
      #   if present
      #
      # @return [nil]
      #   otherwise
      #
      # @api private
      #
      def first_child
        children.first
      end

      # Write whitespace
      #
      # @return [undefined]
      #
      # @api private
      #
      def ws
        write(WS)
      end

      # Call emit contents of block indented
      #
      # @return [undefined]
      #
      # @api private
      #
      def indented
        buffer.indent
        yield
        buffer.unindent
      end

    end # Emitter

  end # Generator
end # SQL
