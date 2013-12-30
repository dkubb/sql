# encoding: utf-8

module SQL
  module Generator

    # DSL Methods
    module DSL

      # Finalize the emitter registry
      #
      # @return [Class<Emitter>]
      #
      # @api private
      def finalize
        @registry.finalize
        self
      end

    private

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
  end # Generator
end # SQL
