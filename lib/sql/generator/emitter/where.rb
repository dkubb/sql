# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Where statement emitter
      class Where < self
        K_WHERE = 'WHERE'.freeze

        handle :where

      private

        # @api private
        def dispatch
          write(K_WHERE, WS)
          visit(first_child)
        end

      end # Where

    end # Emitter
  end # Generator
end # SQL
