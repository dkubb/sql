# encoding: utf-8

require 'spec_helper'

# This spec is trivial, we test more complex generations in
# Via SQL::Generator::Emitter.visit
describe SQL::AST::Node, '#to_sql' do
  let(:object) { described_class.new(type, children) }

  subject { object.to_sql }

  let(:type)     { :true }
  let(:children) { []    }

  it 'returns sql representation' do
    should eql('TRUE')
  end
end
