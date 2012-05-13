# -*- encoding: utf-8 -*-
require File.expand_path('../lib/vose/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["bryanl"]
  gem.email         = ["bryan@osesm.com"]
  gem.description   = %q{Vose: Sample random values from a discrete probability distribution.
}
  gem.summary       = %q{Vose is a Ruby implementation of the Vose Alias Method. It allows for sampling of random values from a discrete probability distribution or in others words, rolling a loaded die.}
  gem.homepage      = "https://github.com/thunderboltlabs/vose"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "vose"
  gem.require_paths = ["lib"]
  gem.version       = Vose::VERSION

  gem.add_development_dependency("pry")
  gem.add_development_dependency("ruby_gntp")
  gem.add_development_dependency("guard-minitest")
  gem.add_development_dependency("guard-bundler")
end
