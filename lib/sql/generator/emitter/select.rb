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
          write_node(INDEX_WHERE, K_WHERE)
          write_node(INDEX_GROUP_BY, K_GROUP_BY)
          write(';')
        end

        # @api private
        def write_node(index, keyword)
          node = children[index]
          if node
            write(WS, keyword, WS)
            visit(node)
          end
        end

      end # Select

    end # Emitter
  end # Generator
end # SQL
