module SQL
  module Generator
    class Emitter
      class Literal

        # Literal Singleton emitter base class
        class Singleton < self

          TYPES = {
            :true  => K_TRUE,
            :false => K_FALSE,
            :null  => K_NULL
          }.freeze

          handle(*TYPES.keys)

        private

          # Perform dispatch
          #
          # @return [undefied]
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
