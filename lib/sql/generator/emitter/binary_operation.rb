# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Binary Operation emitter base class
      class BinaryOperation < self

        TYPES = IceNine.deep_freeze(
          and:    K_AND,
          or:     K_OR,
          mul:    '*',
          add:    '+',
          sub:    '-',
          div:    '/',
          mod:    '%',
          concat: '||',
          eql:    '='
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

      end # BinaryOperation

    end # Emitter
  end # Generator
end # SQL
