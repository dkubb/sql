# encoding: utf-8

module SQL

  # Namepsace for SQL generator
  module Generator

    # Return generated sql statement for node
    #
    # @param [AST::Node] node
    #
    # @return [String]
    #
    # @api private
    #
    def self.generate(node)
      buffer = Buffer.new
      Emitter.visit(node, buffer)
      buffer.content
    end

  end # module Generator

end # module SQL
