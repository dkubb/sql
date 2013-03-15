# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name             = 'sql'
  gem.version          = '0.0.1'
  gem.authors          = ['Dan Kubb']
  gem.email            = 'dan.kubb@gmail.com'
  gem.description      = 'SQL Parser and Generator'
  gem.summary          = gem.description
  gem.homepage         = 'https://github.com/dkubb/sql'

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split($/)
  gem.extra_rdoc_files = %w[LICENSE README.md]
end
