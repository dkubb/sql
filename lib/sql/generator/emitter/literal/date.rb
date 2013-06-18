# encoding: utf-8

module SQL
  module Generator
    class Emitter
      class Literal

        # Literal date emitter
        class Date < self

          handle :date

        private

          # Perform dispatch
          #
          # @return [undefined]
          #
          # @api private
          #
          def dispatch
            write(D_QUOTE, value.iso8601, D_QUOTE)
          end

        end # Date

      end # Literal
    end # Emitter
  end # Generator
end # SQL
