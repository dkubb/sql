# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Identifier emitter class
      class Identifier < self
        handle(:id)

      private

        # Perform dispatch
        #
        # @return [undefined]
        #
        # @api private
        #
        def dispatch
          identifier = first_child.gsub(D_DBL_QUOTE, D_ESCAPED_DBL_QUOTE)
          write(D_DBL_QUOTE, identifier, D_DBL_QUOTE)
        end

      end # Identifier

    end # Emitter
  end # Generator
end # SQL
