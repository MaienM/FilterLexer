require 'treetop'

require 'filter_lexer/version'
require 'filter_lexer/exceptions'
require 'filter_lexer/nodes'
require 'filter_lexer/syntax.treetop'

module FilterLexer
	class Parser
		@parser = FilterLexerParser.new

		class << self
			def parse(data)
				# Pass the data over to the parser instance
				tree = @parser.parse(data)

				# If the AST is nil then there was an error during parsing
				fail ParseException, @parser if tree.nil?

				# Cleanup the tree
				clean_tree(tree)

				return tree
			end

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
