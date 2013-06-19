# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Select statement emitter
      class Select < self
        K_SELECT   = 'SELECT'.freeze
        K_FROM     = 'FROM'.freeze
        K_GROUP_BY = 'GROUP BY'.freeze

        INDEX_WHERE    = 2
        INDEX_GROUP_BY = 3

        handle :select

        children :columns, :identifier

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
          write_where
          write_group_by
          write(';')
        end

        # @api private
        def write_where
          where_node = children[INDEX_WHERE]
          if where_node
            write(WS, K_WHERE, WS)
            visit(where_node)
          end
        end

        # @api private
        def write_group_by
          group_by_node = children[INDEX_GROUP_BY]
          if group_by_node
            write(WS, K_GROUP_BY, WS)
            visit(group_by_node)
          end
        end

      end # Select

    end # Emitter
  end # Generator
end # SQL
