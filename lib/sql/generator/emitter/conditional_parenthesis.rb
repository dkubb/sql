# encoding: utf-8

module SQL
  module Generator
    class Emitter

      # Add conditional parenthesization to an emitter
      module ConditionalParenthesis

        # Emit contents of the block within parenthesis when necessary
        #
        # @return [Boolean]
        #
        # @api private
        def parenthesis
          parenthesize? ? super : yield
        end

        # Test if the expression needs to be parenthesized
        #
        # @return [Boolean]
        #
        # @api private
        def parenthesize?
          raise NotImplementedError, "#{self}##{__method__} is not implemented"
        end

      end # ConditionalParenthesis
    end # Emitter
  end # Generator
end # SQL
