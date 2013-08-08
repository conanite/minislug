# -*- coding: utf-8; mode: ruby  -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'minislug/version'

Gem::Specification.new do |gem|
  gem.name          = "minislug"
  gem.version       = Minislug::VERSION
  gem.authors       = ["Conan Dalton"]
  gem.license       = 'MIT'
  gem.email         = ["conan@conandalton.net"]
  gem.description   = %q{ Bare-bones minimum slugs. No validations or versioning. }
  gem.summary       = %q{ Bare-bones minimum slugs for permalinking your objects with friendly urls }
  gem.homepage      = "https://github.com/conanite/minislug"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
