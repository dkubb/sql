# encoding: utf-8

require File.expand_path('../lib/sql/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'sql'
  gem.version     = SQL::VERSION.dup
  gem.authors     = ['Dan Kubb']
  gem.email       = 'dan.kubb@gmail.com'
  gem.description = 'SQL Parser and Generator'
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/dkubb/sql'
  gem.licenses    = %w[MIT]

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split($/)
  gem.test_files       = `git ls-files -- spec/{unit,integration}`.split($/)
  gem.extra_rdoc_files = %w[LICENSE README.md CONTRIBUTING.md TODO]

  gem.add_runtime_dependency('abstract_type', '~> 0.0.7')
  gem.add_runtime_dependency('adamantium',    '~> 0.1.0')
  gem.add_runtime_dependency('ast',           '~> 1.1.0')
  gem.add_runtime_dependency('ice_nine',      '~> 0.11.0')

  gem.add_development_dependency('bundler', '~> 1.5', '>= 1.5.2')
end
