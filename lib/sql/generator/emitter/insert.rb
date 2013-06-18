# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Insert statement emitter
      class Insert < self
        K_INSERT = 'INSERT INTO'.freeze
        K_VALUES = 'VALUES'.freeze

        handle :insert

        children :identifier, :tuple

      private

        # @api private
        def dispatch
          write(K_INSERT, WS)
          visit(identifier)
          write(WS, K_VALUES, WS)
          visit(tuple)
          write(';')
        end

      end # Insert

    end # Emitter
  end # Generator
end # SQL
