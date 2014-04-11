# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cube/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ticean Bennett"]
  gem.email         = ["ticean@promojam.com"]
  gem.description   = "Ruby client for Cube."
  gem.summary       = "Ruby client for Cube."
  gem.homepage      = "https://github.com/culturejam/cube-ruby-gem"
  gem.license       = "Apache 2.0"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cube-ruby-gem"
  gem.require_paths = ["lib"]
  gem.version       = Cube::VERSION

  gem.add_dependency "faraday", "~> 0.8.8"
  gem.add_dependency "faraday_middleware", "~> 0.8.0"
  gem.add_development_dependency "license_finder"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", "~> 2.11.0"
  gem.add_development_dependency "simplecov"
end
