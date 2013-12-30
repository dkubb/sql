# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Connective operation emitter base class
      class ConnectiveOperation < self

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
            write(WS, TYPES.fetch(node.type), WS)
            visit(right)
          end
        end

        # Emit contents of the block within parenthesis when necessary
        #
        # @return [Boolean]
        #
        # @api private
        def parenthesis
          parenthesize? ? super : yield
        end

        # Test if the connective needs to be parenthesized
        #
        # @return [Boolean]
        #
        # @api private
        def parenthesize?
          parent_type = parent.type if parent
          case parent_type
          when *TYPES.keys
            parent_type != node.type
          else
            false
          end
        end

      end # ConnectiveOperation
    end # Emitter
  end # Generator
end # SQL
