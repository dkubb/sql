# encoding: utf-8

require 'spec_helper'

describe SQL::Generator::Emitter, '.visit' do
  include_context 'emitter'

  context 'with literal singletons' do
    assert_generates s(:true),  'TRUE'
    assert_generates s(:false), 'FALSE'
    assert_generates s(:null),  'NULL'
  end

  context 'with strings' do
    assert_generates s(:string, %q(echo 'Hello')), %q('echo ''Hello''')
  end

  context 'with integers' do
    assert_generates s(:integer, 1), '1'
  end

  context 'with floats' do
    assert_generates s(:float, 1.0), '1.0'
  end

  context 'unary scalars' do
    context 'with unary plus' do
      assert_generates s(:uplus, s(:integer, 1)), '+(1)'
    end

    context 'with unary minus' do
      assert_generates s(:uminus, s(:integer, 1)), '-(1)'
    end

    context 'with unary negation' do
      assert_generates s(:not, s(:true)), '!(TRUE)'
    end
  end

  context 'with dates' do
    assert_generates s(:date, Date.new(2013, 1, 1)), %q('2013-01-01')
  end

  context 'with datetimes' do
    nsec_in_seconds = Rational(1, 10**9)
    datetime        = DateTime.new(2013, 12, 31, 23, 59, 59 + nsec_in_seconds)

    assert_generates s(:datetime, datetime), %q('2013-12-31T23:59:59.000000001+00:00')
  end

  context 'identifiers' do
    assert_generates s(:id, 'echo "oh hai"'), '"echo ""oh hai"""'
  end

  context 'binary operations' do
    context ':and' do
      assert_generates s(:and, s(:id, 'foo'), s(:id, 'bar')), '("foo") AND ("bar")'
    end

    context ':concat' do
      assert_generates s(:concat, s(:string, 'foo'), s(:string, 'bar')), %q[('foo') || ('bar')]
    end

    context ':or' do
      assert_generates s(:or, s(:id, 'foo'), s(:id, 'bar')), '("foo") OR ("bar")'
    end

    context ':eql' do
      assert_generates s(:eql, s(:id, 'foo'), s(:string, 'bar')), %q[("foo") = ('bar')]
    end

    context 'scalars' do
      {
        :mul => '*',
        :add => '+',
        :sub => '-',
        :div => '/',
        :mod => '%'
      }.each do |type, operator|
        assert_generates s(type, s(:integer, 1), s(:integer, 1)), "(1) #{operator} (1)"
      end
    end
  end

  context 'tuples' do
    assert_generates s(:tuple, s(:integer, 1), s(:string, 'foo')), "(1, 'foo')"
  end

  context 'insert' do
    assert_generates(
      s(:insert, s(:id, 'users'), s(:tuple, s(:integer, 1), s(:string, 'foo'))),
      %q(INSERT INTO "users" VALUES (1, 'foo');)
    )
  end

  context 'delete' do
    context 'without where clause' do
      assert_generates s(:delete, s(:id, 'users')), %q(DELETE FROM "users";)
    end
  end

  context 'when emitter is missing' do
    it 'raises argument error' do
      expect { described_class.visit(s(:not_supported, []), stream) }.
        to raise_error(ArgumentError, 'No emitter for node: :not_supported')
    end
  end
end
