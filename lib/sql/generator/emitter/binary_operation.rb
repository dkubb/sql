module SQL
  module Generator
    class Emitter

      class BinaryOperation < self
        TYPES = IceNine.deep_freeze(
          :and => 'AND',
          :or  => 'OR'
        )

        handle(*TYPES.keys)

      private

        def dispatch
          left, right = children

          parentheses { visit(left) }
          write(WS, TYPES.fetch(node.type), WS)
          parentheses { visit(right) }
        end

      end # Identifier

    end # Emitter
  end # Generator
end # SQL
