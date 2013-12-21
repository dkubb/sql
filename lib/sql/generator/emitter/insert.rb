# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Insert statement emitter
      class Insert < self
        handle :insert

        children :identifier, :tuple

      private

        # Perform dispatch
        #
        # @return [undefined]
        #
        # @api private
        #
        def dispatch
          write(K_INSERT, WS)
          visit(identifier)
          write(WS, K_VALUES, WS)
          visit(tuple)
          sc
        end

      end # Insert

    end # Emitter
  end # Generator
end # SQL
