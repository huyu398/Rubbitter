# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubbitter/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubbitter'
  spec.version       = Rubbitter::VERSION
  spec.authors       = ['huyu398']
  spec.email         = ['huyu.sakuya4645@gmail.com']
  spec.summary       = %q(The comfortable twitter client for vim users on Linux.)
  spec.description   = %q(TODO: Write a longer description. Optional.)
  spec.homepage      = 'https://github.com/huyu398/rubbitter'
  spec.license       = 'MIT'

  spec.platform      = 'java'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'jrubyfx', '~> 1.1.0'
  spec.add_runtime_dependency 'oauth', '~> 0.4.7'
  spec.add_runtime_dependency 'twitter', '~> 5.10.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.3.2'
  spec.add_development_dependency 'rspec', '~> 3.0.0'
  spec.add_development_dependency 'rubocop', '~> 0.23.0'
end
