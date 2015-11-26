require 'treetop'

require 'filter_lexer/version'
require 'filter_lexer/exceptions'
require 'filter_lexer/nodes'
require 'filter_lexer/syntax.treetop'

module FilterLexer
	# The parser is your main entrypoint for the lexer
	#
	# You never instantiate it, you just use it's static methods
	class Parser
		@parser = FilterLexerParser.new

		class << self
			# The bread and butter of the entire thing: parsing, and it's pretty simple
			#
			# Just pass in a string, and out comes a parsed tree, or an exception
			#
			# The parsed tree will always be an FilterLexer::Expression object
			# The exception will always be an FilterLexer::ParseException object
			def parse(data)
				# Pass the data over to the parser instance
				tree = @parser.parse(data)

				# If the AST is nil then there was an error during parsing
				fail ParseException, @parser if tree.nil?

				# Cleanup the tree
				clean_tree(tree)

				return tree
			end

			# When using the lexer, it may be useful to have a visual representation of the tree
			#
			# Just pass the tree (or any node in it, if you're only interested in that part) to this function, and a visual
			# representation of the tree will magically appear in stdout
			def output_tree(element, indent = '')
				puts "#{indent}#{element.class}: #{element.text_value}"
				(element.elements || []).each do |e|
					output_tree(e, "#{indent}  ")
				end
			end

			private

			def syn?(node)
				return node.class.name == 'Treetop::Runtime::SyntaxNode'
			end

			def node_elem(node)
				return node.elements || []
			end

			def clean_tree(root_node)
				return if root_node.elements.nil?
				# Clean child elements
				root_node.elements.each { |node| clean_tree(node) }
				# Remove empty syntax elements
				root_node.elements.reject! { |node| node_elem(node).empty? && syn?(node) }
				# Replace syntax elements with just one child with that child
				root_node.elements.map! { |node| (node_elem(node).size == 1 && syn?(node)) ? node.elements.first : node }
			end
		end
	end
end
