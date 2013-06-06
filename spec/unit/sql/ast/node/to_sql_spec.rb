# encoding: utf-8

require 'spec_helper'

describe SQL::AST::Node, '#to_sql' do
  subject { described_class.new(name) }

  let(:name) { :select }

  # TODO: remove this when the next example passes
  it 'returns a string' do
    expect(subject.to_sql).to eql('')
  end

  it 'returns a string' do
    pending 'when #to_sql delegates to Generator' do
      subject.to_sql.should eql('SELECT')
    end
  end
end
