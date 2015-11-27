module FilterLexer
	# A literal is the value (data) of the filter
	class Literal < Treetop::Runtime::SyntaxNode
		def data
			return text_value
		end
	end

	# A boolean is a dual-state true/false literal
	class BooleanLiteral < Literal
		# The data for the boolean will be set during lexing
	end

	# A null is an unset or undefined literal
	class NullLiteral < Literal
		def data
			return nil
		end
	end

	# A string is a series of characters
	class StringLiteral < Literal
		def data
			# Try to parse the string
			string = text_value
			quote_char = string[0]
			string = string.slice(1, string.size - 2)
			string = string.gsub(%[\\\\], %[\\])
			string = string.gsub(%[\\] + quote_char, quote_char)
			return string
		end
	end

	# A number is an integer or a float, with an optional sign and an optional exponent
	class NumberLiteral < Literal
		def data
			return text_value.to_f
		end
	end

	# A datetime is a moment in time
	class DatetimeLiteral < Literal
		def data
			return DateTime.parse(elements.first.data)
		end
	end
end
