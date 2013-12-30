# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Connective operation emitter base class
      class ConnectiveOperation < self
        include ConditionalParenthesis

        TYPES = IceNine.deep_freeze(
          and: O_AND,
          or:  O_OR,
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

        # Test if the connective needs to be parenthesized
        #
        # @return [Boolean]
        #
        # @api private
        def parenthesize?
          kind_of?(parent.class) && parent.node_type != node_type
        end

      end # ConnectiveOperation
    end # Emitter
  end # Generator
end # SQL
