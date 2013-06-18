# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Insert statement emitter
      class Delete < self
        K_DELETE = 'DELETE FROM'.freeze

        handle :delete

      private

        # @api private
        def dispatch
          identifier, where = children
          write(K_DELETE, WS)
          visit(identifier)
          if where
            write(WS)
            visit(where)
          end
          write(';')
        end

      end # Delete

    end # Emitter
  end # Generator
end # SQL
