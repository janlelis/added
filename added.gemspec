# -*- encoding: utf-8 -*-

require File.expand_path('../lib/added/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "added"
  gem.version       = Added::VERSION
  gem.summary       = 'Added hook.'
  gem.description   = 'Module#added: A unified module hook to run code on all instances when adding the module.'
  gem.license       = "MIT"
  gem.authors       = ["Jan Lelis"]
  gem.email         = "hi@ruby.consulting"
  gem.homepage      = "https://github.com/janlelis/added"

  gem.files         = Dir['{**/}{.*,*}'].select { |path| File.file?(path) }
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.required_ruby_version = '~> 2.0'
end
