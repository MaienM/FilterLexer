# FilterLexer

This is a simple treetop implementation for a basic SQL-like filtering syntax.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'filter_lexer'
```

And then execute:

```sh
bundle
```

Or install it yourself as:

```sh
gem install filter_lexer
```

## Usage

To parse a filter, simply do the following:

```ruby
tree = FilterLexer::Parser.parse('foo == "BAR"')
```

If the parsing succeeds, a tree is returned. This tree can be output (for development purposes) using `FilterLexer::Parser.output_tree`.

If the parsing fails, a `ParseException` is raised containing the detials of the failure.

Simple complete example showing success and failure:

```ruby
examples = [
	'foo == "BAR"',
	'foo == "BAR" &&',
]

examples.each do |example|
	begin
		tree = FilterLexer::Parser.parse(example)
		puts "Parsed #{example}"
		FilterLexer::Parser.output_tree(tree)
	rescue FilterLexer::ParseException
		puts $!.message
		puts $!.context
	end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MaienM/FilterLexer.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

