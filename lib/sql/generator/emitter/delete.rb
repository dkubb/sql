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
          write(K_DELETE, WS)
          visit(first_child)
          write(';')
        end

      end # Delete

    end # Emitter
  end # Generator
end # SQL
