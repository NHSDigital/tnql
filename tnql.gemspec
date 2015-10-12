# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tnql/version'

Gem::Specification.new do |spec|
  spec.name          = 'tnql'
  spec.version       = Tnql::VERSION
  spec.authors       = ['PHE NCRS Development Team']
  spec.email         = []

  spec.summary       = 'Tumour Natural Query Language'
  spec.description   = 'Domain Specific Language for querying PHE NCRS datastores'
  spec.homepage      = 'https://github.com/PublicHealthEngland/tnql'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    fail 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").
    reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'ndr_support', '~> 3.0'
  spec.add_dependency 'treetop', '>= 1.4.10'
  spec.add_dependency 'chronic', '~> 0.3.0'
  spec.add_dependency 'activesupport', '>= 3.2.18', '< 5.0.0'
  spec.add_dependency 'activerecord', '>= 3.2.18', '< 5.0.0'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '>= 5.0.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rubocop'
  spec.add_development_dependency 'guard-minitest'
  spec.add_development_dependency 'terminal-notifier-guard' if RUBY_PLATFORM =~ /darwin/
end
