# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Assignment emitter
      class Assignment < self

        handle :assignment

      private

        # Perform dispatch
        #
        # @return [undefined]
        #
        # @api private
        #
        def dispatch
          delimited(children)
        end

      end # Assignment

    end # Emitter
  end # Generator
end # SQL
