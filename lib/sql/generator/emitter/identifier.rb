# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Identifier emitter class
      class Identifier < self

        handle(:id)

        children

      private

        # Perform dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          head, *tail = remaining_children.map do |value|
            value.gsub(D_DBL_QUOTE, D_ESCAPED_DBL_QUOTE)
          end
          write(D_DBL_QUOTE, head, D_DBL_QUOTE)
          tail.each do |value|
            write(D_PERIOD, D_DBL_QUOTE, value, D_DBL_QUOTE)
          end
        end

      end # Identifier
    end # Emitter
  end # Generator
end # SQL
