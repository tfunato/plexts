# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'plexts/version' 

Gem::Specification.new do |spec|
  spec.name          = "plexts"
  spec.version       = Plexts::VERSION
  spec.authors       = ["tfunato"]
  spec.email         = ["tfunato@gmail.com"]
  spec.summary       = %q{Ingress COMM API caller.}
  spec.description   = %q{Ingress COMM API caller.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['plexts']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
