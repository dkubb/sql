# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Predicate emitter
      class Predicate < self

        TYPES = IceNine.deep_freeze(
          where:  K_WHERE,
          having: K_HAVING
        )

        handle(*TYPES.keys)

        children :predicate

      private

        # @see Emitter#dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          write_node(predicate, TYPES.fetch(node.type))
        end

      end # Predicate
    end # Emitter
  end # Generator
end # SQL
