# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sepa_file_parser/version'

Gem::Specification.new do |spec|
  # For explanations see http://docs.rubygems.org/read/chapter/20
  spec.name          = 'sepa_file_parser'
  spec.version       = SepaFileParser::VERSION
  spec.authors       = ['Tobias Schoknecht']
  spec.email         = ['tobias.schoknecht@viafintech.com']
  spec.description   = %q{A parser for sepa files format}
  spec.summary       = %q{Gem for parsing camt, pain, ... files into a speaking object.}
  spec.homepage      = 'https://github.com/viafintech/sepa_file_parser'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*.rb', 'lib/**/*.rake'] # Important!
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake',    '~> 13.2.1'
  spec.add_development_dependency 'rspec',   '~> 3.13.0'
  spec.add_development_dependency 'builder', '~> 3.2.4'

  spec.add_runtime_dependency 'bigdecimal'
  spec.add_runtime_dependency 'nokogiri'
  spec.add_runtime_dependency 'time'
end
