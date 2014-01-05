# encoding: utf-8

module SQL

  # An SQL fuzzer
  class Fuzzer
    include Enumerable

    # Initialize a Fuzzer
    #
    # @param [#to_ast] ast
    #
    # @return [undefined]
    #
    # @api public
    def initialize(ast)
      @ast = ast.to_ast
    end

    # Iterate over each ast in the set
    #
    # @example
    #   fuzzer = SQL::Fuzzer.new(ast)
    #   fuzzer.each { |ast| ... }
    #
    # @yield [ast]
    #
    # @yieldparam [SQL::AST::Node] ast
    #   each ast in the set
    #
    # @return [self]
    #
    # @api public
    def each
      return to_enum unless block_given?
      # TODO: yield 0 or more mutated AST objects
      yield @ast
      self
    end

  end # Fuzzer
end # SQL
