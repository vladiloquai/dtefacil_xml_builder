# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dtefacil_xml_builder/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["vla"]
  gem.email         = ["vladimir@acid.cl"]
  gem.description   = %q{Facilita la construcción y manipulacion de xml necesarios para DTE Fácil 1.2}
  gem.summary       = %q{Construye y manipula xml para DTE Fácil 1.2}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "dtefacil_xml_builder"
  gem.require_paths = ["lib"]
  gem.version       = DtefacilXmlBuilder::VERSION
  gem.add_runtime_dependency 'builder'
  gem.add_runtime_dependency 'rest-client'
end
