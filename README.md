# TNQL [![Build Status](https://travis-ci.org/PublicHealthEngland/tnql.svg?branch=master)](https://travis-ci.org/PublicHealthEngland/tnql)

Tumour Natural Query Language (TNQL) is a [Treetop](http://treetop.rubyforge.org/) driven Domain Specific Language (DSL) used by the Public Health England (PHE) National Cancer Registration Service (NCRS) to identify cohorts of tumours.

Used for analysis, research and day-to-day operations, it was first created in March 2011 to empower non-technical users to write sophisticated human readable queries without the need to know or understand the underlying datastore and/or schema.

In moving it into a gem, TNQL is being further decoupled from the specifics of the NCRS systems by producing an intermediate representation, known as Disease Intermediate Representation (DIR). This allows us to:

1. implement separate DIR adapters for different datastores (e.g. SQL and NoSQL datastores);
2. utilize the same DIR adapters for different but over-lapping DSLs, starting with the Congenital Anomaly Natural Query Language (CANQL); and
3. pass DIR queries to non-ruby backend systems using any simple format like JSON.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tnql'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tnql

## Usage

Here is a simple example showing a TNQL query of all Colon tumours diagnosed at "Hello World" Hospital:

```ruby
require 'tnql'
require 'json'

query = 'All C18 Tumours Diagnosed at Hello World Hospital'
parser = Tnql::Parser.new(query)

if parser.valid?
	puts JSON.dump(parser.meta_data)
end
```

would output:

```json
{"tumour.primarycode":{"begins":["C18"]},"diagnosis.providername":{"begins":"HELLO WORLD","interval":"29...49"}}
```

The parser is case insensitive. An example of an almost fully involved TNQL query is:

> First 27 Final Y0401 Non-invasive Stage 4 Head and Neck Tumours Diagnosed Between August 2010 and Oct 2010 at Hospital RGT01 Treated at Hospital RGN42 With Wait Action and Unprocessed PAS or Somerset Records for Dead Male Patients Who Were Born in 1999, Died Between May 2001 and Aug 2003, and Have no Death Certificate

Please see the tests for many more examples.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

PLEASE NOTE: A side-effect of decoupling TNQL from the NCRS SQL adapter is that more of the grammar logic can be DRYed up, esp. in relation to providers. We plan to fix this and some internal namespacing in forthcoming releases.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PublicHealthEngland/tnql.

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

