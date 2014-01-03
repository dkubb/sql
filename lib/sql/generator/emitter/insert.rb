# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Insert statement emitter
      class Insert < self

        handle :insert

        children :from, :tuple

      private

        # Perform dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          write_command(from, K_INSERT)
          write_node(tuple, K_VALUES)
        end

      end # Insert
    end # Emitter
  end # Generator
end # SQL
