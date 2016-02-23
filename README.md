# Sensu::Plugins::Nexmos
[![Build Status](https://travis-ci.org/wakwanza/sensu-plugins-nexmos.svg?branch=master)](https://travis-ci.org/wakwanza/sensu-plugins-nexmos)

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

~~~json
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
~~~


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wakwanza/sensu-plugins-nexmo.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

