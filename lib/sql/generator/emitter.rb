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

    protected

      # The node type
      #
      # @return [Symbol]
      #
      # @api private
      def node_type
        node.type
      end

    private

      # Return node
      #
      # @return [Parser::AST::Node]
      #
      # @api private
      attr_reader :node

      # Return stream
      #
      # @return [Stream]
      #
      # @api private
      attr_reader :stream

      # Parent node
      #
      # @return [Emitter]
      #
      # @api private
      attr_reader :parent

      # Initialize object
      #
      # @param [Parser::AST::Node] node
      # @param [Stream] stream
      # @param [Emitter] parent
      #
      # @return [undefined]
      #
      # @api private
      def initialize(node, stream, parent = Root.instance)
        @node, @stream, @parent = node, stream, parent
        dispatch
      end

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
        self.class.visit(node, stream, self)
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
        write(WS, keyword, WS)
        visit(node)
      end

    end # Emitter
  end # Generator
end # SQL
