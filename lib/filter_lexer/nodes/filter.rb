module FilterLexer
	# A filter is the core object of the lexer: an indentifier, an relational operator and data
	class Filter < Treetop::Runtime::SyntaxNode
		# The identifier element
		#
		# Of type FilterLexer::Identifier
		def identifier
			return elements[0]
		end

		# The operator element
		#
		# Subclass of FilterLexer::RelationalOperator
		def operator
			return elements[1]
		end

		# The data element
		#
		# Subclass of FilterLexer::Literal
		def data
			return elements[2]
		end
	end
end
