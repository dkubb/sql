# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Join statement emitter
      class Join < self
        TYPES = IceNine.deep_freeze(
          join:         O_JOIN,
          left_join:    O_LEFT_JOIN,
          right_join:   O_RIGHT_JOIN,
          full_join:    O_FULL_JOIN,
          natural_join: O_NATURAL_JOIN,
          cross_join:   O_CROSS_JOIN
        )

        handle(*TYPES.keys)

        children :left, :right, :predicate

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
          if predicate
            write(WS)
            visit(predicate)
          end
        end

      end # Join
    end # Emitter
  end # Generator
end # SQL
