# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Select statement emitter
      class Select < self
        handle :select

        children :columns, :identifier, :where, :group_by

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
          write_node(where, K_WHERE)
          write_node(group_by, K_GROUP_BY)
          sc
        end

      end # Select

    end # Emitter
  end # Generator
end # SQL
