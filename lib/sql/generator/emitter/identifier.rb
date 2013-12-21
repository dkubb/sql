# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Identifier emitter class
      class Identifier < self

        handle(:id)

        children :value

      private

        # Perform dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          identifier = value.gsub(D_DBL_QUOTE, D_ESCAPED_DBL_QUOTE)
          write(D_DBL_QUOTE, identifier, D_DBL_QUOTE)
        end

      end # Identifier
    end # Emitter
  end # Generator
end # SQL
