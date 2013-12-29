# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Select statement emitter
      class Select < self
        handle :select

        children :fields, :from, :where, :group_by, :having

      private

        # @see Emitter#dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          write(K_SELECT, WS)
          visit(fields)
          write_node(from,     K_FROM)
          write_node(where,    K_WHERE)
          write_node(group_by, K_GROUP_BY)
          write_node(having,   K_HAVING)
        end

      end # Select
    end # Emitter
  end # Generator
end # SQL
