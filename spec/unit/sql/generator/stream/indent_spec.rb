# encoding: utf-8

require 'spec_helper'

describe SQL::Generator::Stream, '#indent' do
  subject { object.indent }

  let(:object) { described_class.new }

  it 'indents with two chars' do
    ((object << 'foo').indent << 'bar').indent << 'baz'
    expect(object.output).to eql("foo\n  bar\n    baz")
  end
end
