module FilterLexer
	# An logical operator is the glue between filters
	class LogicalOperator < Treetop::Runtime::SyntaxNode
	end

	# An logical OR operator
	class OrOperator < LogicalOperator
	end

	# An logical AND operator
	class AndOperator < LogicalOperator
	end
end
