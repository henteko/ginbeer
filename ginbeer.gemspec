# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ginbeer/version'

Gem::Specification.new do |gem|
  gem.name          = "ginbeer"
  gem.version       = Ginbeer::VERSION
  gem.authors       = ["henteko"]
  gem.email         = ["henteko07@gmail.com"]
  gem.description   = %q{ginbeer is git authors display}
  gem.summary       = %q{ginbeer is git authots display}
  gem.homepage      = "https://github.com/henteko/ginbeer"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.executables   << 'ginbeer'
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'thor'
end
