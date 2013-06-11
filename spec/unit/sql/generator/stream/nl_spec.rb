# encoding: utf-8

require 'spec_helper'

describe SQL::Generator::Stream, '#nl' do
  let(:object) { described_class.new }

  subject { object.nl }

  it 'writes a newline' do
    object << 'foo'
    subject
    object << 'bar'
    expect(object.output).to eql("foo\nbar")
  end

  it_behaves_like 'a command method'
end
