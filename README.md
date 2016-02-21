# Sensu::Plugins::Nexmos

Sensu handler plugin for nexmo sms and voice alerts.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sensu-plugins-nexmos'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sensu-plugins-nexmos

## Usage

{
	"nexmos":
		{
			"api_key":"NEXMO_API_KEY env variable or explicityl set here",
			"api_secret":"NEXMO_API_SECRET env variable or explicitly set here",
			"voice": false,
			"recipients":{
				"1800456789":{
				"sensu_roles":[],
				"sensu_checks"[],
				"sensu_level":1
				}
			}
  	}
}

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec sensu-plugins-nexmos` to use the gem in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wakwanza/sensu-plugins-nexmo.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

