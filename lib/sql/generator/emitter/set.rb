# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Set statement emitter
      class Set < self
        TYPES = IceNine.deep_freeze(
          difference:   O_EXCEPT,
          intersection: O_INTERSECT,
          union:        O_UNION,
        )

        handle(*TYPES.keys)

        children :first

      private

        # Perform dispatch
        #
        # @return [undefined]
        #
        # @api private
        #
        def dispatch
          parenthesis { visit(first) }
          remaining_children.each do |operand|
            write(WS, TYPES.fetch(node.type), WS)
            parenthesis { visit(operand) }
          end
        end

      end # Set

    end # Emitter
  end # Generator
end # SQL
