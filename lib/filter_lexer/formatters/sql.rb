module FilterLexer
	class Expression
		def to_query
			return "#{query_string} #{query_variables}"
		end

		def query_string
			return elements.map(&:query_string).join(' ')
		end

		def query_variables
			return elements.map(&:query_variables).flatten
		end
	end

	class Group
		def query_string
			return "(#{elements.first.query_string})"
		end

		def query_variables
			return elements.first.query_variables
		end
	end

	class Filter
		def query_string
			return "#{identifier.sql} #{operator.sql} ?"
		end

		def query_variables
			return [data.sql]
		end
	end

	class Identifier
		def sql
			return "`#{text_value}`"
		end
	end

	class LogicOperator
		def query_string
			return sql
		end

		def query_variables
			return []
		end
	end

	class OrOperator
		def sql
			return 'OR'
		end
	end

	class AndOperator
		def sql
			return 'AND'
		end
	end

	class Operator
		def query_string
			return sql
		end

		def query_variables
			return []
		end
	end

	class EQOperator
		def sql
			return 'IS' if parent.data.is_a?(ValueSpecial)
			return '='
		end
	end

	class NEQOperator
		def sql
			return 'IS NOT' if parent.data.is_a?(ValueSpecial)
			return '<>'
		end
	end

	class LTOperator
		def sql
			return '<'
		end
	end

	class LEOperator
		def sql
			return '<='
		end
	end

	class GTOperator
		def sql
			return '>='
		end
	end

	class GEOperator
		def sql
			return '>='
		end
	end

	class NotLikeOperator
		def sql
			return 'NOT LIKE'
		end
	end

	class LikeOperator
		def sql
			return 'LIKE'
		end
	end

	class BooleanLiteralFalse
		def sql
			return 'FALSE'
		end
	end

	class BooleanLiteralTrue
		def sql
			return 'TRUE'
		end
	end

	class NullLiteral
		def sql
			return 'NULL'
		end
	end

	class StringLiteral
		def sql
			return text_value
		end
	end

	class NumberLiteral
		def sql
			return text_value
		end
	end
end
