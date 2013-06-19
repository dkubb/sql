# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Group by emitter
      class GroupBy < self
        K_GROUP_BY = 'GROUP BY'.freeze

        handle :group_by

      private

        # @see Emitter#dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          write(K_GROUP_BY, WS)
          delimited(children)
        end

      end # GroupBy

    end # Emitter
  end # Generator
end # SQL
