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
    def self.generate(node)
      stream = Stream.new
      Emitter.visit(node, stream)
      stream.output
    end

  end # module Generator
end # module SQL
