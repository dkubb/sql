# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Field names emitter
      class Fields < self
        handle :fields

      private

        # @see Emitter#dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          delimited(children)
        end

      end # Fields
    end # Emitter
  end # Generator
end # SQL
