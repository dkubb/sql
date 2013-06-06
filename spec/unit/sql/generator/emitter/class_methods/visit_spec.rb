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
    assert_generates s(:true),    'TRUE'
    assert_generates s(:false),   'FALSE'
    assert_generates s(:null),    'NULL'
  end

  context 'with strings' do
    assert_generates s(:string, %q(echo 'Hello')), %q('echo ''Hello''')
  end

  context 'with integers' do
    assert_generates s(:int, 1), '1'
  end

  context 'with floats' do
    assert_generates s(:float, 1.0), '1.0'
  end

  context 'unary scalars' do
    context 'with unary plus' do
      assert_generates s(:uplus, s(:int, 1)), '+(1)'
    end

    context 'with unary minus' do
      assert_generates s(:uminus, s(:int, 1)), '-(1)'
    end

    context 'with unary negation' do
      assert_generates s(:not, s(:true)), '!(TRUE)'
    end
  end

  context 'identifiers' do
    assert_generates s(:id, 'echo "oh hai"'), '"echo ""oh hai"""'
  end

  context 'binary operations' do
    context ':and' do
      assert_generates s(:and, s(:id, 'foo'), s(:id, 'bar')), '("foo") AND ("bar")'
    end

    context ':concat' do
      assert_generates s(:concat, s(:string, 'foo'), s(:string, 'bar')), %q[('foo') || ('bar')]
    end

    context ':or' do
      assert_generates s(:or, s(:id, 'foo'), s(:id, 'bar')), '("foo") OR ("bar")'
    end

    context 'scalars' do
      {
        :mul => '*',
        :add => '+',
        :sub => '+',
        :div => '/',
        :mod => '%'
      }.each do |type, operator|
        assert_generates s(type, s(:int, 1), s(:int, 1)), "(1) #{operator} (1)"
      end
    end
  end

  context 'when emitter is missing' do
    it 'raises argument error' do
      expect { described_class.visit(s(:not_supported, []), buffer) }.
        to raise_error(ArgumentError, 'No emitter for node: :not_supported')
    end
  end
end
