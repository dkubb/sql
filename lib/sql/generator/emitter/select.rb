# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Select statement emitter
      class Select < self
        K_SELECT = 'SELECT'.freeze
        K_FROM   = 'FROM'.freeze

        handle :select

        children :columns, :identifier

      private

        # @see Emitter#dispatch
        #
        # @return [undefined]
        #
        # @api private
        def dispatch
          write(K_SELECT, WS)
          visit(columns)
          write(WS, K_FROM, WS)
          visit(identifier)
          remaining_children.each do |clause|
            write(WS)
            visit(clause)
          end
          write(';')
        end

      end # Select

    end # Emitter
  end # Generator
end # SQL
