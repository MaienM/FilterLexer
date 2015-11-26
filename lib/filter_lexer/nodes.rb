module FilterLexer
	# The root element, expression is a collection of other expressions and and/or operators
	class Expression < Treetop::Runtime::SyntaxNode
	end

	# A group is simply an expression in parenthesis
	class Group < Treetop::Runtime::SyntaxNode
	end

	# A filter is the core object of the lexer: an indentifier, an operator and a data
	class Filter < Treetop::Runtime::SyntaxNode
		# The identifier element
		#
		# Of type FilterLexer::Identifier
		def identifier
			return elements[0]
		end

		# The operator element
		#
		# Subclass of FilterLexer::Operator
		def operator
			return elements[1]
		end

		# The value element
		#
		# Subclass of FilterLexer::Value
		def data
			return elements[2]
		end
	end

	# An logic operator is the glue between filters
	class LogicOperator < Treetop::Runtime::SyntaxNode
	end

	class OrOperator < LogicOperator
	end

	class AndOperator < LogicOperator
	end

	# An identifier is the target (variable) of the filter
	class Identifier < Treetop::Runtime::SyntaxNode
	end

	# An operator is the type (function) of the filter
	class Operator < Treetop::Runtime::SyntaxNode
	end

	class EQOperator < Operator
	end

	class NEQOperator < Operator
	end

	class LTOperator < Operator
	end

	class LEOperator < Operator
	end

	class GTOperator < Operator
	end

	class GEOperator < Operator
	end

	class NotLikeOperator < Operator
	end

	class LikeOperator < Operator
	end

	# A value is the data of the filter
	class Value < Treetop::Runtime::SyntaxNode
	end

	class ValueSpecial < Value
	end

	class ValueScalar < Value
	end

	class BooleanLiteralFalse < ValueSpecial
	end

	class BooleanLiteralTrue < ValueSpecial
	end

	class NullLiteral < ValueSpecial
	end

	class StringLiteral < ValueScalar
	end

	class NumberLiteral < ValueScalar
	end
end
