module SQL
  module Generator
    class Emitter

      class BinaryOperation < self
        TYPES = IceNine.deep_freeze(
          :and    => K_AND,
          :or     => K_OR,
          :mul    => '*',
          :add    => '+',
          :sub    => '-',
          :div    => '/',
          :mod    => '%',
          :concat => '||',
        )

        handle(*TYPES.keys)

      private

        def dispatch
          left, right = children

          parentheses { visit(left) }
          write(WS, TYPES.fetch(node.type), WS)
          parentheses { visit(right) }
        end

      end # BinaryOperation

    end # Emitter
  end # Generator
end # SQL
