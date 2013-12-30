# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Delimited names emitter
      class Delimited < self

        TYPES = IceNine.deep_freeze(
          group_by: K_GROUP_BY,
          order_by: K_ORDER_BY
        )

        handle(*TYPES.keys)

      private

        # @see Emitter#dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          write(WS, TYPES.fetch(node_type), WS)
          delimited(children)
        end

      end # Delimited
    end # Emitter
  end # Generator
end # SQL
