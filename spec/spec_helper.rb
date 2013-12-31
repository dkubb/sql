# encoding: utf-8

if ENV['COVERAGE'] == 'true'
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]

  SimpleCov.start do
    command_name 'spec:unit'

    add_filter 'config'
    add_filter 'spec'
    add_filter 'vendor'

    minimum_coverage 99.81
  end
end

require 'devtools/spec_helper'
require 'sql'
require 'bigdecimal'

RSpec.configure do |config|
  config.include(SQL::NodeHelper)
  config.extend(SQL::NodeHelper)
  config.extend(EmitterSpecHelper)

  config.expect_with :rspec do |expect_with|
    expect_with.syntax = :expect
  end
end
