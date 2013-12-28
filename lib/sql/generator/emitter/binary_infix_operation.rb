# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Binary infix operation emitter base class
      class BinaryInfixOperation < self

        TYPES = IceNine.deep_freeze(
          and:     O_AND,
          or:      O_OR,
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
          concat:  O_CONCAT
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
          visit(left)
          write(WS, TYPES.fetch(node.type), WS)
          visit(right)
        end

      end # BinaryInfixOperation
    end # Emitter
  end # Generator
end # SQL
