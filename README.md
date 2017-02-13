[![Build
Status](https://travis-ci.org/Phybbit/maxminddb-geolite2-city.svg?branch=master)](https://travis-ci.org/Phybbit/maxminddb-geolite2-city)

# Maxminddb::Geolite2::City

This gem bundles the GeoLite2-City.mmdb database along with the [MaxMinDB gem](https://github.com/yhirose/maxminddb).
This way you don't need to manage the DB version yourself.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'maxminddb-geolite2-city'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install maxminddb-geolite2-city

## Usage

```ruby
require 'maxminddb/geolite2/city'

MaxMindDB.default_city_db.lookup('8.8.8.8').city.name
# => "Mountain View"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Update to the latest DB:

$ rake update_db

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Phybbit/maxminddb-geolite2-city.git.

## License

This product includes GeoLite2 data created by MaxMind, available from
<a href="http://www.maxmind.com">http://www.maxmind.com</a>.
