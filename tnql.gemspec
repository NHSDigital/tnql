# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tnql/version'

Gem::Specification.new do |spec|
  spec.name          = 'tnql'
  spec.version       = Tnql::VERSION
  spec.authors       = ['PHE NDR IT Development Team']
  spec.email         = []

  spec.summary       = 'Tumour Natural Query Language'
  spec.description   = 'Domain Specific Language for querying PHE NCRAS datastores'
  spec.homepage      = 'https://github.com/PublicHealthEngland/tnql'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").
                       reject { |f| f.match(%r{^(test|spec|features)/}) }
  # SECURE BNS 2018-08-06: Minimise sharing of (public-key encrypted) slack secrets in .travis.yml
  spec.files         -= %w[.travis.yml] # Not needed in the gem
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.2.0'

  spec.add_dependency 'activesupport', '>= 3.2.18', '< 6'
  spec.add_dependency 'ndr_support', '>= 3.0', '< 6'
  spec.add_dependency 'treetop', '>= 1.4.10'
  spec.add_dependency 'chronic', '~> 0.3.0'

  spec.add_development_dependency 'ndr_dev_support', '~> 3.1', '>= 3.1.2'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest', '>= 5.0.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rubocop'
  spec.add_development_dependency 'guard-minitest'
  spec.add_development_dependency 'terminal-notifier-guard' if RUBY_PLATFORM =~ /darwin/
end
