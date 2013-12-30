# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Emitter class for sort operations
      class SortOperation < self

        TYPES = IceNine.deep_freeze(
          asc:  O_ASC,
          desc: O_DESC
        )

        handle(*TYPES.keys)

        children :field

      private

        # Perform dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          visit(field)
          write(WS, TYPES.fetch(node_type))
        end

      end # SortOperation
    end # Emitter
  end # Generator
end # SQL
