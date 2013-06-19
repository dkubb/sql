# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Delimited names emitter
      class Delimited < self
        handle :delimited

      private

        # @see Emitter#dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          delimited(children)
        end

      end # Delimited

    end # Emitter
  end # Generator
end # SQL
