module SQL
  module Generator
    class Emitter
      class Literal

        # Literal string emitter base class
        class String < self

          handle :str

        private

          def dispatch
            write(D_QUOTE, first_child.gsub(D_QUOTE, D_ESCAPED_QUOTE), D_QUOTE)
          end

        end # String

      end # Literal
    end # Emitter
  end # Generator
end # SQL
