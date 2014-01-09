# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Select statement emitter
      class Select < self
        include ConditionalParenthesis

        handle :select

        children :fields, :from

      private

        # @see Emitter#dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          parenthesis do
            write_command(fields, K_SELECT)
            write_node(from, K_FROM) if from
            remaining_children.each(&method(:visit))
          end
        end

        # Test if the statement needs to be parenthesized
        #
        # @return [Boolean]
        #
        # @api private
        def parenthesize?
          !parent.equal?(Root.instance)
        end

      end # Select
    end # Emitter
  end # Generator
end # SQL
