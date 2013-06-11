# encoding: utf-8

module EmitterSpecHelper

  # Create an example that the expected SQL is generated
  #
  # @param [SQL::AST::Node] node
  # @param [String] expectation
  #
  # @return [undefined]
  #
  # @api public
  def assert_generates(node, expectation)
    it "generates #{node.type} correctly" do
      SQL::Generator::Emitter.visit(node, stream)
      expect(stream.output).to eql(expectation)
    end
  end

end # EmitterSpecHelper
