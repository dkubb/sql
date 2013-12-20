# encoding: utf-8

module SQL
  module Generator

    # Registry for emitters
    #
    # @api private
    class Registry

      # Initialize registry
      #
      # @return [undefined]
      #
      # @api private
      def initialize
        @emitters = Hash.new do |_emitters, type|
          fail UnknownTypeError, "No emitter for node: #{type.inspect}"
        end
      end

      # Return emitter based on type
      #
      # @param [Symbol] type
      #
      # @return [Emitter]
      #
      # @api private
      def [](type)
        @emitters[type]
      end

      # Register an emitter
      #
      # @param [Symbol] type
      # @param [Emitter] emitter
      #
      # @return [self]
      #
      # @api private
      def []=(type, emitter)
        @emitters[type] = emitter
        self
      end

      # Finalize the registry
      #
      # @return [self]
      #
      # @api private
      def finalize
        IceNine.deep_freeze(self)
      end

    end # Registry

  end # Generator
end # SQL
