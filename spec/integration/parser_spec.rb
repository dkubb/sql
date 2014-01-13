# encoding: utf-8

require 'spec_helper'

describe SQL::Parser do
  def self.assert_parses(sql, expectation)
    it "parses #{sql.inspect} correctly" do
      string_io = StringIO.new(sql)
      expect(SQL::Parser.parse(string_io).result).to eq(expectation)
    end
  end

  context 'boolean' do
    assert_parses 'SELECT TRUE',  s(:select, s(:fields, s(:true)))
    assert_parses 'SELECT FALSE', s(:select, s(:fields, s(:false)))
    assert_parses 'SELECT NULL',  s(:select, s(:fields, s(:null)))
  end

  context 'character string literal' do
    assert_parses "SELECT ''",      s(:select, s(:fields, s(:string, '')))
    assert_parses "SELECT 'a'",     s(:select, s(:fields, s(:string, 'a')))
    assert_parses "SELECT 'a'''",   s(:select, s(:fields, s(:string, "a'")))
    assert_parses "SELECT '''a'",   s(:select, s(:fields, s(:string, "'a")))
    assert_parses "SELECT 'a''b'",  s(:select, s(:fields, s(:string, "a'b")))
    assert_parses "SELECT 'a' 'b'", s(:select, s(:fields, s(:string, "ab")))

    pending do
      string = 'Iñtërnâtiônàlizætiøn'
      assert_parses "SELECT '#{string}'", s(:select, s(:fields, s(:string, string)))
    end
  end

  context 'exact numeric literal' do
    assert_parses 'SELECT 1',   s(:select, s(:fields, s(:integer, 1)))
    assert_parses 'SELECT 1.0', s(:select, s(:fields, s(:float, 1.0)))

    assert_parses 'SELECT 1E1',  s(:select, s(:fields, s(:float, 10.0)))
    assert_parses 'SELECT 1E+1', s(:select, s(:fields, s(:float, 10.0)))
    assert_parses 'SELECT 1E-1', s(:select, s(:fields, s(:float, 0.1)))

    assert_parses 'SELECT +1E1',  s(:select, s(:fields, s(:float, 10.0)))
    assert_parses 'SELECT +1E+1', s(:select, s(:fields, s(:float, 10.0)))
    assert_parses 'SELECT +1E-1', s(:select, s(:fields, s(:float, 0.1)))

    assert_parses 'SELECT -1E1',  s(:select, s(:fields, s(:float, -10.0)))
    assert_parses 'SELECT -1E+1', s(:select, s(:fields, s(:float, -10.0)))
    assert_parses 'SELECT -1E-1', s(:select, s(:fields, s(:float, -0.1)))

    assert_parses 'SELECT 1.5E30',  s(:select, s(:fields, s(:float, 1.5e+30)))
    assert_parses 'SELECT 1.5E+30', s(:select, s(:fields, s(:float, 1.5e+30)))
    assert_parses 'SELECT 1.5E-30', s(:select, s(:fields, s(:float, 1.5e-30)))

    assert_parses 'SELECT +1.5E30',  s(:select, s(:fields, s(:float, 1.5e+30)))
    assert_parses 'SELECT +1.5E+30', s(:select, s(:fields, s(:float, 1.5e+30)))
    assert_parses 'SELECT +1.5E-30', s(:select, s(:fields, s(:float, 1.5e-30)))

    assert_parses 'SELECT -1.5E30',  s(:select, s(:fields, s(:float, -1.5e+30)))
    assert_parses 'SELECT -1.5E+30', s(:select, s(:fields, s(:float, -1.5e+30)))
    assert_parses 'SELECT -1.5E-30', s(:select, s(:fields, s(:float, -1.5e-30)))
  end

  context 'term' do
    assert_parses 'SELECT 1 * 1', s(:select, s(:fields, s(:mul, s(:integer, 1), s(:integer, 1))))
    assert_parses 'SELECT 1 / 1', s(:select, s(:fields, s(:div, s(:integer, 1), s(:integer, 1))))
    assert_parses 'SELECT 1 + 1', s(:select, s(:fields, s(:add, s(:integer, 1), s(:integer, 1))))
    assert_parses 'SELECT 1 - 1', s(:select, s(:fields, s(:sub, s(:integer, 1), s(:integer, 1))))
    assert_parses 'SELECT 1 ^ 1', s(:select, s(:fields, s(:pow, s(:integer, 1), s(:integer, 1))))
    assert_parses 'SELECT 1 % 1', s(:select, s(:fields, s(:mod, s(:integer, 1), s(:integer, 1))))
  end

  context 'as' do
    assert_parses 'SELECT 1 AS "test"', s(:select, s(:fields, s(:as, s(:integer, 1), s(:id, 'test'))))
  end

  context 'identifier' do
    assert_parses 'SELECT "a"',     s(:select, s(:fields, s(:id, 'a')))
    assert_parses 'SELECT "a2"',    s(:select, s(:fields, s(:id, 'a2')))
    assert_parses 'SELECT "a"""',   s(:select, s(:fields, s(:id, 'a"')))
    assert_parses 'SELECT "a""b"',  s(:select, s(:fields, s(:id, 'a"b')))
    assert_parses 'SELECT "a_b"',   s(:select, s(:fields, s(:id, 'a_b')))
    assert_parses 'SELECT "a"."b"', s(:select, s(:fields, s(:id, 'a', 'b')))

    id = "a#{128.chr}"
    assert_parses %Q[SELECT "#{id}"], s(:select, s(:fields, s(:id, id)))
  end
end
