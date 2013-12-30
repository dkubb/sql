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
            write(WS, TYPES.fetch(node_type), WS)
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
          case parent
          when self.class
            parent.node_type != node_type
          else
            false
          end
        end

      end # ConnectiveOperation
    end # Emitter
  end # Generator
end # SQL
