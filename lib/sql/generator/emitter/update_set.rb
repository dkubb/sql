# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Update set emitter
      class UpdateSet < self
        handle :set

      private

        # @see Emitter#dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          write(WS, K_SET, WS)
          delimited(children)
        end

      end # UpdateSet
    end # Emitter
  end # Generator
end # SQL
