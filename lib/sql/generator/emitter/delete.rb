# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Insert statement emitter
      class Delete < self
        K_DELETE = 'DELETE FROM'.freeze

        handle :delete

        children :identifier, :where

      private

        # @see Emitter#dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          write(K_DELETE, WS)
          visit(identifier)
          if where
            write(WS, K_WHERE, WS)
            visit(where)
          end
          write(';')
        end

      end # Delete

    end # Emitter
  end # Generator
end # SQL
