# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Select statement emitter
      class Select < self
        COMMAND = K_SELECT

        handle :select

        children :fields, :from

      private

        # @see Emitter#dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          write_command(fields)
          write_node(from, K_FROM)
          remaining_children.each(&method(:visit))
        end

      end # Select
    end # Emitter
  end # Generator
end # SQL
