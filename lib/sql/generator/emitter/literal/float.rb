module SQL
  module Generator
    class Emitter
      class Literal

        # Literal float emitter base class
        class Float < self

          handle :float

        private

          def dispatch
            write(first_child.to_s)
          end

        end # String

      end # Literal
    end # Emitter
  end # Generator
end # SQL
