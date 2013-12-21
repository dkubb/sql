# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Binary infix operation emitter base class
      class BinaryInfixOperation < self

        TYPES = IceNine.deep_freeze(
          and:    O_AND,
          or:     O_OR,
          mul:    O_MULTIPLY,
          add:    O_PLUS,
          sub:    O_MINUS,
          div:    O_DIVIDE,
          mod:    O_MOD,
          pow:    O_POW,
          concat: O_CONCAT,
          eq:     O_EQ,
          is:     O_IS
        )

        handle(*TYPES.keys)

        children :left, :right

      private

        # Perform dispatch
        #
        # @return [undefined]
        #
        # @api private
        #
        def dispatch
          visit(left)
          write(WS, TYPES.fetch(node.type), WS)
          visit(right)
        end

      end # BinaryInfixOperation

    end # Emitter
  end # Generator
end # SQL
