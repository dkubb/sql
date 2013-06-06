# encoding: utf-8

require 'spec_helper'

describe SQL::Fuzzer, '#each' do
  subject { described_class.new(ast) }

  let(:ast) { stub('ast').as_null_object }

  before do
    ast.should_receive(:to_ast)
  end

  context 'with a block' do
    it 'is a command method' do
      expect(subject.each {}).to be(subject)
    end

    it 'yields the ast' do
      expect { |block| subject.each(&block) }.to yield_with_args(ast)
    end
  end

  context 'without a block' do
    it 'returns an enumerator' do
      expect(subject.each).to be_instance_of(to_enum.class)
    end

    it 'yields the ast in #each' do
      expect { |block| subject.each.each(&block) }.to yield_with_args(ast)
    end
  end
end
