# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name    = 'enumerated_constants'
  spec.version = '0.2.0'
  spec.authors = ['Tom Collier']
  spec.email   = ['collier@apartmentlist.com']

  spec.summary = 'Ruby mix-in that emulates the classic enum'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f =~ %r{^spec/} }

  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end
