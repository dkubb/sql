# encoding: utf-8

module SQL
  module Generator
    class Emitter
      class Literal

        # Literal time emitter
        class Time < self

          # Display the time with nanoseconds
          TIME_SCALE = 9

          handle :time

        private

          # Perform dispatch
          #
          # @return [undefined]
          #
          # @api private
          #
          def dispatch
            unfrozen = self.class.unfrozen(value)
            write(D_QUOTE, unfrozen.utc.iso8601(TIME_SCALE), D_QUOTE)
          end

        end # Time

      end # Literal
    end # Emitter
  end # Generator
end # SQL
