# encoding: utf-8

require 'spec_helper'

describe SQL::Generator::Stream, '#output' do
  subject { object.output }

  let(:object) { described_class.new }

  shared_examples_for 'stream output' do
    it 'contains expected output' do
      should eql(expected_output)
    end
  end

  context 'with empty string' do
    let(:expected_output) { '' }

    it_behaves_like 'stream output'
  end

  context 'with filled stream' do
    before do
      object << 'foo'
    end

    let(:expected_output) { 'foo' }

    it_behaves_like 'stream output'
  end
end
