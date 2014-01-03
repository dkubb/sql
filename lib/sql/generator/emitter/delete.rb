# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Delete statement emitter
      class Delete < self
        handle :delete

        children :from, :where

      private

        # @see Emitter#dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          write_command(from, K_DELETE)
          visit(where) if where
        end

      end # Delete
    end # Emitter
  end # Generator
end # SQL
