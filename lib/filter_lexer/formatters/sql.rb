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
			return [data.data]
		end
	end

	class Identifier
		def sql
			return "`#{text_value}`"
		end
	end

	class LogicalOperator
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

	class RelationalOperator
		def query_string
			return sql
		end

		def query_variables
			return []
		end
	end

	class EQOperator
		def sql
			case parent.data
				when BooleanLiteral, NullLiteral
					return 'IS'
				else
					return '='
			end
		end
	end

	class NEQOperator
		def sql
			case parent.data
				when BooleanLiteral, NullLiteral
					return 'IS NOT'
				else
					return '<>'
			end
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

	class LikeOperator
		def sql
			return 'LIKE'
		end
	end

	class NotLikeOperator
		def sql
			return 'NOT LIKE'
		end
	end
end
