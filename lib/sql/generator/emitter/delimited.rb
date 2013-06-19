# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Column names emitter
      class Delimited < self
        handle :assignments, :columns

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
