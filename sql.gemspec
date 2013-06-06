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

  gem.add_runtime_dependency('ast', '~> 1.0.2')

  gem.add_development_dependency('bundler', '~> 1.3', '>= 1.3.5')
end
