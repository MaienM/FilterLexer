module FilterLexer
	# The root element, expression is a collection of other expressions and and/or operators
	class Expression < Treetop::Runtime::SyntaxNode
	end

	# A group is simply an expression in parenthesis
	class Group < Treetop::Runtime::SyntaxNode
	end
end
