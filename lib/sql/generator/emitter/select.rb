# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Select statement emitter
      class Select < self
        K_SELECT   = 'SELECT'.freeze
        K_FROM     = 'FROM'.freeze
        K_GROUP_BY = 'GROUP BY'.freeze

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

        # @api private
        def write_node(node, keyword)
          if node
            write(WS, keyword, WS)
            visit(node)
          end
        end

      end # Select

    end # Emitter
  end # Generator
end # SQL
