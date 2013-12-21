# encoding: utf-8

module SQL
  module Generator
    class Emitter
      class Literal

        # Literal datetime emitter
        class Datetime < self

          # Display the time with nanoseconds
          TIME_SCALE = 9

          handle :datetime

        private

          # Perform dispatch
          #
          # @return [undefined]
          #
          # @api private
          def dispatch
            write(D_QUOTE, value.new_offset.iso8601(TIME_SCALE), D_QUOTE)
          end

        end # Datetime
      end # Literal
    end # Emitter
  end # Generator
end # SQL
