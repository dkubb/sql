module SQL
  module Generator
    class Emitter

      # Unary Scalar emitter class
      class UnaryScalar < self

        TYPES = IceNine.deep_freeze(
          :uplus  => O_PLUS,
          :uminus => O_MINUS,
          :not    => O_NEGATION
        )

        handle(*TYPES.keys)

      private

        # Perform dispatch
        #
        # @return [undefined]
        #
        # @api private
        #
        def dispatch
          write(TYPES.fetch(node.type))
          parentheses { visit(first_child) }
        end

      end # UnaryScalar

    end # Emitter
  end # Generator
end # SQL
