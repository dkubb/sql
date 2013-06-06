module SQL
  module Generator
    class Emitter
      class Literal

        # Literal string emitter base class
        class String < self

          handle :string

        private

          def dispatch
            write(quote(first_child))
          end

          def quote(string)
            escaped = string.gsub(Emitter::D_QUOTE, Emitter::D_ESCAPED_QUOTE)
            escaped.insert(0, Emitter::D_QUOTE) << Emitter::D_QUOTE
          end

        end # String

      end # Literal
    end # Emitter
  end # Generator
end # SQL
