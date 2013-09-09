# encoding: utf-8

module SQL
  module Generator
    class Emitter
      class Literal

        # Literal Singleton emitter base class
        class Singleton < self

          TYPES = IceNine.deep_freeze(
            true:  K_TRUE,
            false: K_FALSE,
            null:  K_NULL
          )

          handle(*TYPES.keys)

        private

          # Perform dispatch
          #
          # @return [undefined]
          #
          # @api private
          #
          def dispatch
            write(TYPES.fetch(node.type))
          end

        end # Singleton

      end # Literal
    end # Emitter
  end # Generator
end # SQL
