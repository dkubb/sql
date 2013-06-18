# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Tuple emitter
      class Tuple < self

        handle :tuple

      private

        # @api private
        def dispatch
          brackets { delimited(children) }
        end

      end # Tuple

    end # Emitter
  end # Generator
end # SQL
