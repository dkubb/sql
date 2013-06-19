# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Where statement emitter
      class Where < self
        K_WHERE = 'WHERE'.freeze

        handle :where

        children :predicate

      private

        # @api private
        def dispatch
          write(K_WHERE, WS)
          visit(predicate)
        end

      end # Where

    end # Emitter
  end # Generator
end # SQL
