# encoding: utf-8

require 'spec_helper'

describe SQL::Generator::Stream, '#<<' do
  subject { object << string }

  let(:object) { described_class.new }
  let(:string) { 'foo' }

  specify do
    expect { subject }.to change { object.output }.from('').to('foo')
  end

  # Yeah duplicate, mutant will be improved ;)
  it 'prefixes with indentation' do
    (object << 'foo').indent << 'bar' << 'baz'
    expect(object.output).to eql("foo\n  barbaz")
  end

  it_behaves_like 'a command method'
end
