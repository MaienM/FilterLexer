# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filter_lexer/version'

Gem::Specification.new do |spec|
	spec.name          = 'filter_lexer'
	spec.version       = FilterLexer::VERSION
	spec.authors       = ['Michon van Dooren']
	spec.email         = ['michon1992@gmail.com']

	spec.summary       = 'A basic lexer that supports basic sql-like filtering logic.'
	spec.description   = 'Simple treetop lexer that supports writing filters in an SQL-like manner.'
	spec.homepage      = 'http://github.com/MaienM/FilterLexer'
	spec.license       = 'MIT'

	if spec.respond_to?(:metadata)
		spec.metadata['allowed_push_host'] = 'https://rubygems.org'
	else
		fail 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
	end

	spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
	spec.bindir        = 'exe'
	spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
	spec.require_paths = ['lib']

	spec.add_development_dependency 'bundler', '~> 1.10'
	spec.add_development_dependency 'rake', '~> 10.0'
	spec.add_development_dependency 'rspec'
	spec.add_development_dependency 'rubocop'
	spec.add_dependency 'treetop', '~> 1.6'
end
