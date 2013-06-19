# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Update statement emitter
      class Update < self
        K_UPDATE = 'UPDATE'.freeze
        K_SET    = 'SET'.freeze

        handle :update

        children :identifier, :assignment, :where

      private

        # @see Emitter#dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          write(K_UPDATE, WS)
          visit(identifier)
          write(WS, K_SET, WS)
          visit(assignment)
          if where
            write(WS)
            visit(where)
          end
          write(';')
        end

      end # Update

    end # Emitter
  end # Generator
end # SQL
