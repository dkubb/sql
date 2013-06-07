module SQL

  # A mixin for node helpers
  module NodeHelper

    # Return new node
    #
    # @param [Symbol] type
    #
    # @return [AST::Node]
    #
    # @api private
    #
    def s(type, *children)
      AST::Node.new(type, children)
    end

  end # NodeHelper

end # SQL
