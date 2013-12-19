# encoding: utf-8

module SQL
  module Generator

    # Emitter base class
    class Emitter
      include Adamantium::Flat, AbstractType, Constants

      # Regitry of Emitter subclasses by node type
      REGISTRY = Registry.new

      # Define named child
      #
      # @param [Symbol] name
      # @param [Fixnum] index
      #
      # @return [undefined]
      #
      # @api private
      #
      def self.define_named_child(name, index)
        define_method(name) do
          children.at(index)
        end
      end

      # Define remaining children
      #
      # @param [Fixnum] from_index
      #
      # @return [undefined]
      #
      # @api private
      #
      def self.define_remaining_children(from_index)
        define_method(:remaining_children) do
          children.drop(from_index)
        end
      end

      # Create name helpers
      #
      # @return [undefined]
      #
      # @api private
      #
      def self.children(*names)
        names.each_with_index do |name, index|
          define_named_child(name, index)
        end
        define_remaining_children(names.length)
      end
      private_class_method :children

      # Emit node into stream
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
          REGISTRY[type] = self
        end
      end
      private_class_method :handle

      # Initialize object
      #
      # @param [Parser::AST::Node] node
      # @param [Stream] stream
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(node, stream)
        @node, @stream = node, stream
        dispatch
      end
      private_class_method :new

      # Visit node
      #
      # @param [Parser::AST::Node] node
      # @param [Stream] stream
      #
      # @return [Class<Emitter>]
      #
      # @api private
      #
      def self.visit(node, stream)
        REGISTRY[node.type].emit(node, stream)
        self
      end

      # Finalize the emitter registry
      #
      # @return [Class<Emitter>]
      #
      # @api private
      #
      def self.finalize
        REGISTRY.finalize
        self
      end

      # Return node
      #
      # @return [Parser::AST::Node] node
      #
      # @api private
      #
      attr_reader :node

      # Return stream
      #
      # @return [Stream] stream
      #
      # @api private
      #
      attr_reader :stream
      protected :stream

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

      # Write semicolon
      #
      # @return [undefined]
      #
      # @api private
      #
      def sc
        write(SC)
      end

      # Write strings into stream
      #
      # @return [undefined]
      #
      # @api private
      #
      def write(*strings)
        strings.each { |string| stream << string }
      end

    end # Emitter

  end # Generator
end # SQL
