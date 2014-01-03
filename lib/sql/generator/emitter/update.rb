# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Update statement emitter
      class Update < self

        handle :update

        children :from, :assignment, :where

      private

        # @see Emitter#dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          write_command(from, K_UPDATE)
          visit(assignment)
          visit(where) if where
        end

      end # Update
    end # Emitter
  end # Generator
end # SQL
