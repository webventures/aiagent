# aiagent

[![Gem Version](https://badge.fury.io/rb/claude-ruby.svg)](https://badge.fury.io/rb/claude-ruby) [![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Maintainability](https://api.codeclimate.com/v1/badges/08c7e7b58e9fbe7156eb/maintainability)](https://codeclimate.com/github/webventures/claude-ruby/maintainability) [![CI](https://github.com/webventures/claude-ruby/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/webventures/claude-ruby/actions/workflows/ci.yml)

`claude-ruby` gem is an unofficial ruby SDK for interacting with the Anthropic API, for generating and streaming messages through Claude

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aiagent'
```

And then execute:

```ruby
$ bundle install
```

Or install it yourself as:

```ruby
$ gem install aiagent
```

## Initializer

Create an initializer called config/initializers/ai_agent.rb \
And in that file simply require the agents that you'll use in your project.

E.g. \
require "ai_agent/ai_agent/claude"

## Usage

To use this gem you'll need an API key for the agents that you want to use.

Set your API keys as environment variables.

** Example usage coming soon in the next version of this gem **

## Changelog

For a detailed list of changes for each version of this project, please see the [CHANGELOG](CHANGELOG.md).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/webventures/aiagent.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Trademarks

This gem refers to agents that have been developed by third parties. Ownership of the respective trademarks remains with those parties.
