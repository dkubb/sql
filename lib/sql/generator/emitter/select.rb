# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Select statement emitter
      class Select < self
        K_SELECT = 'SELECT'.freeze
        K_FROM   = 'FROM'.freeze

        handle :select

        children :columns, :identifier, :where

      private

        # @see Emitter#dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          write(K_SELECT, WS)
          visit(columns)
          write(WS, K_FROM, WS)
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
