# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Unary prefix operation emitter base class
      class UnaryPrefixOperation < self

        TYPES = IceNine.deep_freeze(
          count:  O_COUNT,
          sum:    O_SUM,
          min:    O_MIN,
          max:    O_MAX,
          avg:    O_AVG,
          var:    O_VAR,
          stddev: O_STDDEV,
          sqrt:   O_SQRT,
          abs:    O_ABS,
          length: O_LENGTH
        )

        handle(*TYPES.keys)

        children :operand

      private

        # Perform dispatch
        #
        # @return [undefined]
        #
        # @api private
        #
        def dispatch
          write(TYPES.fetch(node.type), WS)
          parenthesis { visit(operand) }
        end

      end # UnaryPrefixOperation

    end # Emitter
  end # Generator
end # SQL
