# encoding: utf-8

module SQL
  module Generator
    class Emitter
      class Literal

        # Literal string emitter
        class String < self

          handle :string

        private

          # Perform dispatch
          #
          # @return [undefined]
          #
          # @api private
          #
          def dispatch
            write(D_QUOTE, value.gsub(D_QUOTE, D_ESCAPED_QUOTE), D_QUOTE)
          end

        end # String

      end # Literal
    end # Emitter
  end # Generator
end # SQL
