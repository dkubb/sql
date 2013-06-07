module SQL
  module Generator
    class Emitter
      class Literal

        # Literal integer emitter
        class Integer < self

          handle :int

        private

          # Perform dispatch
          #
          # @return [undefined]
          #
          # @api private
          #
          def dispatch
            write(first_child.to_s)
          end

        end # Integer

      end # Literal
    end # Emitter
  end # Generator
end # SQL
