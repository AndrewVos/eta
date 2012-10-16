# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eta/version'

Gem::Specification.new do |gem|
  gem.name          = "eta"
  gem.version       = Eta::VERSION
  gem.authors       = ["Andrew Vos"]
  gem.email         = ["andrew.vos@gmail.com"]
  gem.description   = %q{Progress Bar that learns how long tasks usually take}
  gem.summary       = %q{}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency "childprocess"
end
