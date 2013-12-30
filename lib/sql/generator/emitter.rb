# encoding: utf-8

module SQL
  module Generator

    # Emitter base class
    class Emitter
      extend DSL
      include Adamantium::Flat, AbstractType, Constants

      # Default delimiter
      DEFAULT_DELIMITER = D_COMMA + WS

      # Regitry of Emitter subclasses by node type
      @registry = Registry.new

      # Return node
      #
      # @return [Parser::AST::Node] node
      #
      # @api private
      attr_reader :node

      # Return stream
      #
      # @return [Stream] stream
      #
      # @api private
      attr_reader :stream
      protected :stream

      # Hook called when class is inherited
      #
      # @param [Class] descendant
      #   the class inheriting Emitter
      #
      # @return [undefined]
      #
      # @api private
      def self.inherited(descendant)
        descendant.instance_variable_set(:@registry, @registry)
      end

      # Emit node into stream
      #
      # @return [Class<Emitter>]
      #
      # @api private
      def self.emit(*arguments)
        new(*arguments)
        self
      end

      # Visit node
      #
      # @param [Parser::AST::Node] node
      # @param [Stream] stream
      #
      # @return [Class<Emitter>]
      #
      # @api private
      def self.visit(node, stream)
        @registry[node.type].emit(node, stream)
        self
      end

      # Initialize object
      #
      # @param [Parser::AST::Node] node
      # @param [Stream] stream
      #
      # @return [undefined]
      #
      # @api private
      def initialize(node, stream)
        @node, @stream = node, stream
        dispatch
      end
      private_class_method :new

    private

      # Emit contents of block within parenthesis
      #
      # @return [undefined]
      #
      # @api private
      def parenthesis
        write(PARENTHESIS_L)
        yield
        write(PARENTHESIS_R)
      end

      # Dispatch helper
      #
      # @param [Parser::AST::Node] node
      #
      # @return [undefined]
      #
      # @api private
      def visit(node)
        self.class.visit(node, stream)
      end

      # Emit delimited body
      #
      # @param [Enumerable<Parser::AST::Node>] nodes
      # @param [String] delimiter
      #
      # @return [undefined]
      #
      # @api private
      def delimited(nodes, delimiter = DEFAULT_DELIMITER)
        head, *tail = nodes
        visit(head)
        tail.each do |node|
          write(delimiter)
          visit(node)
        end
      end

      # Return children of node
      #
      # @return [Array<Parser::AST::Node>]
      #
      # @api private
      def children
        node.children
      end

      # Write strings into stream
      #
      # @return [undefined]
      #
      # @api private
      def write(*strings)
        strings.each(&stream.method(:<<))
      end

      # Write the command
      #
      # @return [undefined]
      #
      # @api private
      def write_command(node)
        write(self.class::COMMAND, WS)
        visit(node)
      end

      # Write the node if it exists
      #
      # @return [undefined]
      #
      # @api private
      def write_node(node, keyword)
        return unless node
        write(WS, keyword, WS)
        visit(node)
      end

    end # Emitter
  end # Generator
end # SQL
