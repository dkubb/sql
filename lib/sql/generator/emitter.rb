# encoding: utf-8

module SQL
  module Generator

    # Emitter base class
    class Emitter
      include Adamantium::Flat, AbstractType, Constants

      @@registry = Registry.new

      # Emit node into buffer
      #
      # @return [Class<Emitter>]
      #
      # @api private
      #
      def self.emit(*arguments)
        new(*arguments)
        self
      end

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
          @@registry[type] = self
        end
      end
      private_class_method :handle

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
      # @return [Class<Emitter>]
      #
      # @api private
      #
      def self.visit(node, buffer)
        @@registry[node.type].emit(node, buffer)
        self
      end

      # Finalize the emitter registry
      #
      # @return [Class<Emitter>]
      #
      # @return [self]
      #
      # @api private
      #
      def self.finalize
        @@registry.finalize
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

      # Emit contents of block within brackets
      #
      # @return [undefined]
      #
      # @api private
      #
      def brackets
        write(BRACKET_L)
        yield
        write(BRACKET_R)
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
      #def delimited(nodes, delimiter = DEFAULT_DELIMITER)
        #max = nodes.length - 1
        #nodes.each_with_index do |node, index|
          #visit(node)
          #write(delimiter) if index < max
        #end
      #end

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
      #def nl
        #buffer.nl
      #end

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
      #def ws
        #write(WS)
      #end

      # Call emit contents of block indented
      #
      # @return [undefined]
      #
      # @api private
      #
      #def indented
        #buffer.indent
        #yield
        #buffer.unindent
      #end

    end # Emitter

  end # Generator
end # SQL
