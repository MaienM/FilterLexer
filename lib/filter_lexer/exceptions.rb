module FilterLexer
	class ParseException < StandardError
		def initialize(parser)
			@index = parser.failure_index
			@input = parser.input
		end

		def message
			return "Parse error at index #{@index}"
		end

		def context
			size = @input.size
			i1 = [0, @index - 40].max
			i2 = [size, @index + 40].min

			context = @input.slice(i1..i2)
			context = "...#{context}" if i1 > 0
			context = "#{context}..." if i2 < size

			relpos = @index - i1
			relpos += 1 if i1 > 0

			return context + "\r\n" + ' ' * relpos + '^'
		end
	end
end
