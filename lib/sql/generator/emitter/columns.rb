# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Column names emitter
      class Columns < self
        handle :columns

      private

        # @see Emitter#dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          delimited(children)
        end

      end # Delete

    end # Emitter
  end # Generator
end # SQL
