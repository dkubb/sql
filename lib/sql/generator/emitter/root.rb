# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Root emitter
      class Root < self
        include Singleton

        # Initialize a root emitter object
        #
        # @return [undefined]
        #
        # @api private
        def initialize
        end

      protected

        # The node type
        #
        # @return [nil]
        #
        # @api private
        def node_type
        end

      end # Root
    end # Emitter
  end # Generator
end # SQL
