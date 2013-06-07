# encoding: utf-8

require 'spec_helper'

describe SQL::Generator do
  subject { object.generate(node) }

  let(:object) { described_class }
  let(:node)   { s(:true)        }

  it 'generates the expected SQL' do
    expect(subject).to eql('TRUE')
  end
end
