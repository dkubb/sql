# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Binary infix operation emitter base class
      class BinaryInfixOperation < self
        include ConditionalParenthesis

        TYPES = IceNine.deep_freeze(
          in:      O_IN,
          between: O_BETWEEN,
          add:     O_PLUS,
          sub:     O_MINUS,
          mul:     O_MULTIPLY,
          div:     O_DIVIDE,
          mod:     O_MOD,
          pow:     O_POW,
          is:      O_IS,
          eq:      O_EQ,
          ne:      O_NE,
          gt:      O_GT,
          gte:     O_GTE,
          lt:      O_LT,
          lte:     O_LTE,
          concat:  O_CONCAT,
          as:      O_AS
        )

        handle(*TYPES.keys)

        children :left, :right

      private

        # Perform dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          parenthesis do
            visit(left)
            write(WS, TYPES.fetch(node_type), WS)
            visit(right)
          end
        end

        def parenthesize?
          # TODO: when a node has lower precedence than it's parent it
          # should be parenthesized.

          # TODO: when a left node has the same precedence as it's parent,
          # and is right associative, it should be parenthesized.
          # eg: s(:pow, s(:pow, 2, 3), 4) -> (2 ^ 3) ^ 4

          # TODO: when a right node has the same precedence as it's parent,
          # and is left associative, it should be parenthesized.
          # eg: s(:sub, 2, s(:sub, 3, 4)) -> 2 - (3 - 4)

          true
        end

      end # BinaryInfixOperation
    end # Emitter
  end # Generator
end # SQL
