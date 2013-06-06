module SQL
  module Generator
    class Emitter

      class UnaryScalar < self
        TYPES = {
          :uplus  => O_PLUS,
          :uminus => O_MINUS,
          :not    => O_NEGATION
        }.freeze

        handle(*TYPES.keys)

      private

        def dispatch
          write(TYPES.fetch(node.type))
          parentheses { visit(first_child) }
        end

      end # UnaryPlus

    end # Emitter
  end # Generator
end # SQL
