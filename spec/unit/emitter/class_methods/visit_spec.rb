require 'spec_helper'

describe SQL::Generator::Emitter, '.visit' do
  let(:object) { described_class }

  subject { object.visit(node, buffer) }

  let(:buffer) { SQL::Generator::Buffer.new }

  def self.assert_generates(node, expectation)
    it "should generate #{node.type} correctly" do
      SQL::Generator::Emitter.visit(node, buffer)
      expect(buffer.content).to eql(expectation)
    end
  end

  context 'with literal singletons' do
    assert_generates s(:true),  'TRUE'
    assert_generates s(:false), 'FALSE'
    assert_generates s(:null),  'NULL'
  end

  context 'with strings' do
    assert_generates s(:string, %q(echo 'Hello')), %q('echo ''Hello''')
  end
end
