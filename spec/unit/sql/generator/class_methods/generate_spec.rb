# encoding: utf-8

require 'spec_helper'

describe SQL::Generator do
  subject { object.generate(node) }

  let(:object) { described_class               }
  let(:node)   { stub('node')                  }
  let(:buffer) { mock('buffer').as_null_object }

  before do
    SQL::Generator::Buffer.stub(:new => buffer)
    SQL::Generator::Emitter.stub(:visit)
  end

  it 'returns the buffer content' do
    content = stub('content')
    buffer.should_receive(:content).and_return(content)
    expect(subject).to be(content)
  end

  it 'visits the ast' do
    SQL::Generator::Emitter.should_receive(:visit).with(node, buffer)
    subject
  end
end
