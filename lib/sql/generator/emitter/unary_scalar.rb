module SQL
  module Generator
    class Emitter

      class UnaryScalar < self
        TYPES = { :uplus => '+' }.freeze

        handle(*TYPES.keys)

      private

        def dispatch
          write(TYPES.fetch(node.type))
          visit(first_child)
        end

      end # UnaryPlus

    end # Emitter
  end # Generator
end # SQL
