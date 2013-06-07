if ENV['COVERAGE'] == 'true'
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]

  SimpleCov.start do
    command_name     'spec:unit'
    add_filter       'config/'
    add_filter       'spec/'
    minimum_coverage 95.93
  end
end

require 'sql'
require 'devtools/spec_helper'

# require spec support files and shared behavior
Dir[File.expand_path('../{support,shared}/**/*.rb', __FILE__)].each do |file|
  require file
end

RSpec.configure do |config|
  config.include(SQL::NodeHelper)
  config.extend(SQL::NodeHelper)
  config.extend(EmitterSpecHelper)
  config.expect_with :rspec do |expect_with|
    expect_with.syntax = :expect
  end
end
