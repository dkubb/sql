# encoding: utf-8

module SQL
  module Generator

    # Registry for emitters
    #
    # @api private
    class Registry

      def initialize
        @emitters = Hash.new do |_emitters, type|
          raise UnknownTypeError, "No emitter for node: #{type.inspect}"
        end
      end

      def [](key)
        @emitters[key]
      end

      def []=(key, value)
        @emitters[key] = value
      end

      def finalize
        IceNine.deep_freeze(self)
      end

    end # Registry

  end # Generator
end # SQL
