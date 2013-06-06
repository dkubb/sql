module SQL
  module Generator
    class Emitter

      class BinaryOperation < self
        TYPES = {
          :and => 'AND'
        }.freeze

        handle(*TYPES.keys)

      private

        def dispatch
          left, right = children

          parentheses do
            visit(left)
            write(WS, TYPES.fetch(node.type), WS)
            visit(right)
          end
        end

      end # Identifier

    end # Emitter
  end # Generator
end # SQL
