require 'spec_helper'

RSpec.describe FilterLexer::Parser do
	before do
		@parser = FilterLexer::Parser.instance_variable_get('@parser')
	end

	describe '.parse' do
		@tests = {
			identifier: {
				success: %w(foo FOO fOo foo_bar foo0),
				failure: %w(_foo 8bar foo-bar foo\ bar),
			},

			value: {
				success: {
					# Null
					%[null] => nil,
					%[NULL] => nil,
					%[nul] => nil,
					%[NUL] => nil,
					%[nil] => nil,
					%[NIL] => nil,
					# Boolean
					%[true] => true,
					%[TRUE] => true,
					%[on] => true,
					%[ON] => true,
					%[yes] => true,
					%[YES] => true,
					%[false] => false,
					%[FALSE] => false,
					%[off] => false,
					%[OFF] => false,
					%[no] => false,
					%[NO] => false,
					# Numeric
					%[1] => 1,
					%[-1] => -1,
					%[+1] => +1,
					%[1e1] => 1e1,
					%[-1e1] => -1e1,
					%[+1e1] => +1e1,
					%[1.1] => 1.1,
					%[-1.1] => -1.1,
					%[+1.1] => +1.1,
					%[1.1e1] => 1.1e1,
					%[-1.1e1] => -1.1e1,
					%[+1.1e1] => +1.1e1,
					# String
					%["foo"] => %[foo],
					%['foo'] => %[foo],
					%["foo'bar"] => %[foo'bar],
					%['foo"bar'] => %[foo"bar],
					%["foo\\"bar"] => %[foo"bar],
					%['foo\\'bar'] => %[foo'bar],
					%['2000-30-30'] => %[2000-30-30],
					# Datetime
					%["2000-01-01T10:10:10.000Z"] => DateTime.new(2000, 01, 01, 10, 10, 10),
					%["2000-01-01T10:10:10"] => DateTime.new(2000, 01, 01, 10, 10, 10),
					%["2000-01-01T10:10"] => DateTime.new(2000, 01, 01, 10, 10),
					%["2000-01-01T"] => DateTime.new(2000, 01, 01),
					%["2000-01-01"] => DateTime.new(2000, 01, 01),
				},
				failure: [
					%[NuLL],
					%[NiL],
					%[NuL],
					%[True],
					%[False],
					%[1e-1],
					%[1e1.1],
					%[1.1.1],
					%[1e1e1],
					%[1+1],
					%[1-1],
					%[foo],
					%["foo],
					%[foo"],
					%['foo],
					%[foo'],
					%["foo'],
					%["foo\\\\"bar"],
					%['foo\\\\'bar'],
				],
			},

			like_operator: %w(like LIKE =~),
			not_like_operator: ['not like', 'NOT LIKE', '!=~'],
			ge_operator: %w(>= ge GE),
			gt_operator: %w(> gt GT),
			le_operator: %w(<= le LE),
			lt_operator: %w(< lt LT),
			eq_operator: %w(== eq EQ is IS),
			neq_operator: ['!=', '<>', 'neq', 'NEQ', 'not is', 'NOT IS', 'is not', 'IS NOT'],
			and_operator: %w(&& AND and),
			or_operator: %w(|| OR or),

			filter: {
				success: [
					%[foo =~ "BAR"],
					%[foo > 10],
					%[foo > "2000-01-01"],
					%[foo == "BAR"],
					%[foo == 10],
					%[foo == true],
					%[foo == null],
					%[foo eq "BAR"],
					%[foo eq"BAR"],
				],
				failure: [
					%[foo =~ 10],
					%[foo =~ true],
					%[foo =~ null],
					%[foo > "BAR"],
					%[foo > true],
					%[foo > null],
					%[foo > "2000"],
					%[fooeq "BAR"],
				],
			},

			expression: {
				success: [
					%[foo == "BAR"],
					%[   foo=="BAR"   ],
					%[(foo == "BAR")],
					%[(    foo == "BAR"  )],
					%[(foo == "BAR)")],
					%[foo == "BAR" && bar =~ "HE%LO"],
					%[(foo == "BAR" && bar =~ "HE%LO")],
					%[(foo == "BAR" && bar =~ "HE%LO") || foo == "BARR"],
					%[foo == "BAR" && bar =~ "HE%LO" && foo == "BARR"],
					%[(foo == "BAR" && bar =~ "HE%LO" && foo == "BARR")],
					%[(foo == "BAR" && bar =~ "HE%LO" && foo == "BARR") || (foo == "BARRR")],
					%[(foo == "BAR" && bar =~ "HE%LO" && foo > "2000-01-01") || (foo == "BARRR" || bar == "FOOOO")],
				],
				failure: [
					%[foo],
					%["BAR"],
					%[==],
					%[10],
					%[foo ==],
					%[== "BAR"],
					%[()],
					%[(foo == "BAR"],
					%[foo == "BAR" &&],
					%[(foo) == "BAR"],
				],
			},
		}

		@tests.each do |node, examples|
			describe "with root = :#{node}" do
				before do
					@parser.root = node
				end

				after do
					@parser.root = :expression
				end

				examples = { success: [*examples], failure: [] } unless examples.is_a?(Hash)

				examples[:success].each do |example, value|
					message = "should parse #{example}"
					message += " as #{value}" unless value.nil?
					it message do
						expect { FilterLexer::Parser.parse(example) }.not_to raise_error
						expect(FilterLexer::Parser.parse(example).data).to eq(value) unless value.nil?
					end
				end

				examples[:failure].each do |example|
					it "should not parse #{example}" do
						expect { FilterLexer::Parser.parse(example) }.to raise_error(FilterLexer::ParseException)
					end
				end
			end
		end
	end
end
