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
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 3.3.1'

  spec.add_dependency 'activesupport', '~> 7.2.x'
  spec.add_dependency 'darthjee-core_ext', '~> 3.x'
end
