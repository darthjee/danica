# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'danica/version'

Gem::Specification.new do |spec|
  spec.name = 'danica'
  spec.version = Danica::VERSION
  spec.authors = ['Darthjee']
  spec.email = ['darthjee@gmail.com']
  spec.summary = 'Danica'

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '~> 5.2.x'
  spec.add_runtime_dependency 'darthjee-core_ext', '~> 2.x'

  spec.add_development_dependency 'bundler',             '~> 2.6.8'
  spec.add_development_dependency 'pry-nav',            '~> 1.0.0'
  spec.add_development_dependency 'rake',               '>= 13.2.1'
  spec.add_development_dependency 'rspec',              '>= 3.9.0'
  spec.add_development_dependency 'rspec-core',         '>= 3.9.3'
  spec.add_development_dependency 'rspec-expectations', '>= 3.9.4'
  spec.add_development_dependency 'rspec-mocks',        '>= 3.9.1'
  spec.add_development_dependency 'rspec-support',      '>= 3.9.4'
  spec.add_development_dependency 'rubocop',            '0.80.1'
  spec.add_development_dependency 'rubocop-rspec',      '1.38.1'
  spec.add_development_dependency 'rubycritic',         '>= 4.6.1'
  spec.add_development_dependency 'simplecov',          '~> 0.17.1'
  spec.add_development_dependency 'yard',               '>= 0.9.26'
  spec.add_development_dependency 'yardstick',          '>= 0.9.9'
end
