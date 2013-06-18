# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Insert statement emitter
      class Insert < self

        handle :insert

      private

        # @api private
        def dispatch
          identifier, tuple = children
          write('INSERT INTO')
          ws
          visit(identifier)
          ws
          write('VALUES')
          visit(tuple)
          write(';')
        end

      end # Insert

    end # Emitter
  end # Generator
end # SQL
