# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Delete statement emitter
      class Delete < self
        handle :delete

        children :identifier, :where

      private

        # @see Emitter#dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          write(K_DELETE, WS, K_FROM, WS)
          visit(identifier)
          write_node(where, K_WHERE)
          sc
        end

      end # Delete

    end # Emitter
  end # Generator
end # SQL
