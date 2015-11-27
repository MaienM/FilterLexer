module FilterLexer
	# An relational operator is the type (function) of the filter
	class RelationalOperator < Treetop::Runtime::SyntaxNode
	end

	# An relational equality operator
	class EQOperator < RelationalOperator
	end

	# An relational negative equality operator
	class NEQOperator < RelationalOperator
	end

	# An relational less-than operator
	class LTOperator < RelationalOperator
	end

	# An relational less-than-or-equal operator
	class LEOperator < RelationalOperator
	end

	# An relational greater-than operator
	class GTOperator < RelationalOperator
	end

	# An relational greater-than-or-equal operator
	class GEOperator < RelationalOperator
	end

	# An relational string matching operator
	class LikeOperator < RelationalOperator
	end

	# An relational negative string matching operator
	class NotLikeOperator < RelationalOperator
	end
end
