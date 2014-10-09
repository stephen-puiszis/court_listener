# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'court_listener/version'

Gem::Specification.new do |spec|
  spec.name          = "court_listener"
  spec.version       = CourtListener::VERSION
  spec.authors       = ["stephen-puiszis"]
  spec.email         = ["spuiszis@gmail.com"]
  spec.summary       = "Ruby REST API wrapper for Court Listener"
  spec.description   = "Ruby REST API wrapper for Court Listener"
  spec.homepage      = "https://github.com/stephen-puiszis/court_listener"
  spec.license       = "MIT"

  # spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end
