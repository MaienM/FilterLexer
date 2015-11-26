require 'bundler/setup'
Bundler.setup

require 'filter_lexer'

RSpec.configure do |config|
	config.disable_monkey_patching!
	config.order = :random
	Kernel.srand config.seed
end
