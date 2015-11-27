require 'spec_helper'
require 'filter_lexer/formatters/sql'

RSpec.describe 'filter_lexer/formatters/sql' do
	describe FilterLexer::Expression do
		describe '.to_query' do
			@tests = {
				'foo == "BAR"' => ['`foo` = ?', 'BAR'],
				'foo == null' => ['`foo` IS ?', nil],
				'foo == "BAR" && bar == null' => ['`foo` = ? AND `bar` IS ?', 'BAR', nil],
			}

			@tests.each do |input, output|
				it "should format #{input} correctly" do
					tree = FilterLexer::Parser.parse(input)
					expect(tree.query_string).to eq(output.first)
					expect(tree.query_variables).to eq(output.slice(1, 999))
				end
			end
		end
	end
end
