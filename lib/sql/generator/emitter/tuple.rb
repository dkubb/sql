# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Tuple emitter
      class Tuple < self

        handle :tuple

      private

        # Perform dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          parenthesis { delimited(children) }
        end

      end # Tuple
    end # Emitter
  end # Generator
end # SQL
