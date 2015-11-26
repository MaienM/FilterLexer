module FilterLexer
	class ParseException < Exception
		def initialize(parser)
			@index = parser.index
			@input = parser.input
		end

		def message
			return "Parse error at index #{@index}"
		end

		def context
			i1 = @index - 40
			i1 = 0 if i1 < 0
			i2 = @index + 40
			i2 = @input.size if i2 > @input.size

			context = @input.slice(i1..i2)
			if i1 > 0
				context = "...#{context}"
				i1 -= 3
			end
			context = "#{context}..." if i2 < @input.size 

			return context + "\r\n" + ' ' * (@index - i1) + '^'
		end
	end
end
