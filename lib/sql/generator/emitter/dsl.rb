# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Emitter DSL Methods
      module DSL

        # Hook called when another module is extended by this module
        #
        # @param [Module] descendant
        #   the module being extended with Emitter
        #
        # @return [undefined]
        #
        # @api private
        def self.extended(descendant)
          descendant.class_eval { private_class_method :new }
        end

        # Visit node
        #
        # @param [Parser::AST::Node] node
        # @param [Stream] stream
        # @param [Emitter] parent optional
        #
        # @return [Class<Emitter>]
        #
        # @api private
        def visit(node, stream, parent = Emitter::Root.instance)
          @registry[node.type].emit(node, stream, parent)
          self
        end

        # Finalize the emitter registry
        #
        # @return [Class<Emitter>]
        #
        # @api private
        def finalize
          @registry.finalize
          self
        end

      protected

        # Emit node into stream
        #
        # @return [Class<Emitter>]
        #
        # @api private
        def emit(*arguments)
          new(*arguments)
          self
        end

      private

        # Hook called when class is inherited
        #
        # @param [Class] descendant
        #   the class inheriting Emitter
        #
        # @return [undefined]
        #
        # @api private
        def inherited(descendant)
          descendant.instance_variable_set(:@registry, @registry)
        end

        # Register emitter for type
        #
        # @param [Symbol] type
        #
        # @return [undefined]
        #
        # @api private
        def handle(*types)
          types.each { |type| @registry[type] = self }
        end

        # Create name helpers
        #
        # @return [undefined]
        #
        # @api private
        def children(*names)
          names.each_with_index(&method(:define_named_child))
          define_remaining_children(names.length)
        end

        # Define named child
        #
        # @param [Symbol] name
        # @param [Fixnum] index
        #
        # @return [undefined]
        #
        # @api private
        def define_named_child(name, index)
          define_method(name) { children.at(index) }
        end

        # Define remaining children
        #
        # @param [Fixnum] from_index
        #
        # @return [undefined]
        #
        # @api private
        def define_remaining_children(from_index)
          define_method(:remaining_children) { children.drop(from_index) }
        end

      end # DSL
    end # Emitter
  end # Generator
end # SQL
