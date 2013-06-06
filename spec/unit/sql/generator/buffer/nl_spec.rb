require 'spec_helper'

describe SQL::Generator::Buffer, '#nl' do
  let(:object) { described_class.new }

  subject { object.nl }

  it 'indents with two chars' do
    object.append('foo')
    subject
    object.append('bar')
    expect(object.content).to eql("foo\nbar")
  end
end
