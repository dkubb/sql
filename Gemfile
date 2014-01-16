# encoding: utf-8

source 'https://rubygems.org'

gemspec

platform :rbx do
  gem 'rubysl-bigdecimal', '~> 2.0.2'
  gem 'rubysl-enumerator', '~> 2.0.0'
end

group :development, :test do
  gem 'devtools', git: 'https://github.com/rom-rb/devtools.git'
  gem 'racc',     '= 1.4.9'
end

eval_gemfile 'Gemfile.devtools'
