module FilterLexer
	class Expression < Treetop::Runtime::SyntaxNode
	end

	class Group < Treetop::Runtime::SyntaxNode
	end

	class Filter < Treetop::Runtime::SyntaxNode
		def identifier
			return elements[0].sql
		end

		def operator
			return elements[1].sql
		end

		def value
			return elements[2].sql
		end

		def value_class
			return elements[2].class
		end
	end

	# Operators

	class Operator < Treetop::Runtime::SyntaxNode
	end

	class OrOperator < Operator
	end

	class AndOperator < Operator
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

	# Values

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

	# Identifier

	class Identifier < Treetop::Runtime::SyntaxNode
	end
end
