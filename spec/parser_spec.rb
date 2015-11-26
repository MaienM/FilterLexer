require 'spec_helper'

RSpec.describe FilterLexer::Parser do
	before do
		@parser = FilterLexer::Parser.class_variable_get('@@parser')
	end

	describe '.parse' do
		TESTS = {
			identifier: {
				success: %w(foo FOO fOo foo_bar foo0),
				failure: ['_foo', '8bar', 'foo-bar'],
			},

			boolean: {
				success: %w(true TRUE on ON yes YES false FALSE off OFF no NO),
				failure: %w(1 0 True False),
			},
			number: {
				success: ['1', '-1', '+1', '1e1', '-1e1', '+1e1', '1.1', '-1.1', '+1.1', '1.1e1', '-1.1e1', '+1.1e1'],
				failure: ['1e-1', '1e1.1', '1.1.1', '1e1e1', '1+1', '1-1'],
			},
			string: {
				success: ['"foo"', "'foo'", '"foo\'bar"', "'foo\"bar'", '"foo\\"bar"', "'foo\\'bar'"],
				failure: ['foo', '"foo', 'foo"', "'foo", "foo'", '"foo\'', '"foo\\\\"bar"', "'foo\\\\'bar'"],
			},
			null: {
				success: %w(null NULL nul NUL nil NIL),
				failure: %w(NuLL NiL NuL),
			},

			like_operator: ['like', 'LIKE', '~='],
			not_like_operator: ['not like', 'NOT LIKE', '!~='],
			ge_operator: '>=',
			gt_operator: '>',
			le_operator: '<=',
			lt_operator: '<',
			eq_operator: '==',
			neq_operator: ['!=', '<>'],
			and_operator: ['&&', 'AND', 'and'],
			or_operator: ['||', 'OR', 'or'],

			filter: {
				success: [
					'foo ~= "BAR"',
					'foo > 10',
					'foo == "BAR"',
					'foo == 10',
					'foo == true',
					'foo == null',
				],
				failure: [
					'foo ~= 10',
					'foo ~= true',
					'foo ~= null',
					'foo > "BAR"',
					'foo > true',
					'foo > null',
				],
			},

			expression: {
				success: [
					'foo == "BAR"',
					'   foo=="BAR"   ',
					'(foo == "BAR")',
					'(    foo == "BAR"  )',
					'(foo == "BAR)")',
					'foo == "BAR" && bar ~= "HE%LO"',
					'(foo == "BAR" && bar ~= "HE%LO")',
					'(foo == "BAR" && bar ~= "HE%LO") || foo == "BARR"',
					'foo == "BAR" && bar ~= "HE%LO" && foo == "BARR"',
					'(foo == "BAR" && bar ~= "HE%LO" && foo == "BARR")',
					'(foo == "BAR" && bar ~= "HE%LO" && foo == "BARR") || (foo == "BARRR")',
					'(foo == "BAR" && bar ~= "HE%LO" && foo == "BARR") || (foo == "BARRR" || bar == "FOOOO")',
				],
				failure: [
					'foo',
					'"BAR"',
					'==',
					'10',
					'foo ==',
					'== "BAR"',
					'()',
					'(foo == "BAR"',
					'foo == "BAR" &&',
					'(foo) == "BAR"',
				],
			},
		}

		TESTS.each do |node, examples|
			describe "with root = :#{node}" do
				before do
					@parser.root = node
				end

				examples = { success: [*examples], failure: [] } unless examples.is_a?(Hash)

				examples[:success].each do |example|
					it "should parse #{example}" do
						expect { FilterLexer::Parser.parse(example) }.not_to raise_error
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
