module SQL
  module Generator
    class Emitter
      class Literal

        # Literal Singleton emitter base class
        class Singleton < self

        private

          # Perform dispatch
          #
          # @return [undefied]
          #
          # @api private
          #
          def dispatch
            write(self.class::TOKEN)
          end
 
          # Emitter for true literals
          class True < self
            TOKEN = K_TRUE
            handle(:true)
          end # TRue

          # Emitter for false literals
          class False < self
            TOKEN = K_FALSE
            handle(:false)
          end # False

          # Emitter for null literals
          class Null < self
            TOKEN = K_NULL
            handle(:null)
          end # Null

        end # Singleton
      end # Literal
    end # Emitter
  end # Generator
end # SQL
