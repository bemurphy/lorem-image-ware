# -*- encoding: utf-8 -*-
require File.expand_path('../lib/lorem-image-ware/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Brendon Murphy"]
  gem.email         = ["xternal1+github@gmail.com"]
  gem.summary       = %q{rack middleware for proxying requests to lorempixel.com}
  gem.description   = gem.summary
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^test/})
  gem.name          = "lorem-image-ware"
  gem.require_paths = ["lib"]
  gem.version       = LoremImageWare::VERSION

  gem.add_dependency "rack"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rack-test"
  gem.add_development_dependency "minitest"
end
