require 'bundler/gem_tasks'
require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop, [:options]) do |task|
	task.options.push '--cache=false'
end
module RuboCop
	# We use tabs for indentation, not spaces. As many of the RuboCop cops seem
	# to depend on two spaces being used for indentation, we pretend this is
	# what we do. To allow us to still check indentation for correctness, we
	# also change two spaces into tabs, so RuboCop can detect it as invalid
	# indentation.
	class File < ::File
		SPACES = '  '
		TABS = "\t"
		PLACEHOLDER = "\0"

		def self.read(*args)
			source = super(*args)
			source = swap_indents(source)
			return source
		end

		def write(source, *args)
			source = self.class.swap_indents(source)
			return super(source, *args)
		end

		class << self
			def swap_indents(source)
				source = change_to(source, SPACES, PLACEHOLDER)
				source = change_to(source, TABS, SPACES)
				source = change_to(source, PLACEHOLDER, TABS)
				return source
			end

			private

			def change_to(source, from, to)
				return source.gsub(/^((#{from})+)/) { |m| to * (m.size / from.size).to_i }
			end
		end
	end
end
