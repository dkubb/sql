# encoding: utf-8

require 'spec_helper'

describe SQL::Generator::Stream::Indented, '#unindent' do
  subject { object.unindent }

  let(:object) { described_class.new(stream) }
  let(:stream) { SQL::Generator::Stream.new  }

  it 'unindents two chars' do
    ((object << 'foo').indent << 'bar').unindent << 'baz'
    expect(stream.output).to eql("  foo\n    bar\n  baz")
  end
end
