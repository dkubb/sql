# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Set statement emitter
      class Set < self
        TYPES = IceNine.deep_freeze(
          difference:   WS + O_EXCEPT    + WS,
          intersection: WS + O_INTERSECT + WS,
          union:        WS + O_UNION     + WS,
        )

        handle(*TYPES.keys)

      private

        # Perform dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          delimited(children, TYPES.fetch(node_type))
        end

      end # Set
    end # Emitter
  end # Generator
end # SQL
