# aiagent

[![Gem Version](https://badge.fury.io/rb/aiagent.svg)](https://badge.fury.io/rb/aiagent) [![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

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

Example initializer:
```ruby
# config/initializers/ai_agent.rb

require "ai_agent/ai_agent/claude"
require "ai_agent/ai_agent/open_ai"
```

You'll also need to add supporting gems to your Gemfile for each of the agents that you enable.

```ruby
gem 'claude-ruby'
gem 'ruby-openai'
```


## Setup

To use this gem you'll need an API key for the agents that you want to use.

Set your API keys as environment variables, or pass them to the AiAgent initialize method.

Example with environment variables:
```ruby
ENV['ANTHROPIC_API_KEY'] = 'YOUR_ANTHROPIC_API_KEY'

ai_agent = AiAgent::Claude.new
```

Example passing the api_key to the initalizer:
```ruby
ai_agent = AiAgent::Claude.new(api_key: 'ANTHROPIC_API_KEY')
```

## Usage

Basic example usage for OpenAI ChatGPT:

```ruby
ai_agent = AiAgent::OpenAI.new(timeout: 30)
prompt = "Generate 5 inspirational quotes."
messages = [{ 'role': 'user', 'content': prompt }]
response = ai_agent.chat(messages, options: {})
ai_agent.format_response(response)
```

Basic example usage for Anthropic Claude:

```ruby
ai_agent = AiAgent::Claude.new(timeout: 30)
prompt = "Generate 5 inspirational quotes."
messages = [{ 'role': 'user', 'content': prompt }]
response = ai_agent.chat(messages, options: {})
ai_agent.format_response(response)
```


At the API level Claude 'system' message needs to be a parameter in the options rather than an element in the messages array.

Using AiAgent you have the choice of using a Claude-specific 'send_messages' method which takes the data in the format expected by Claude, or you can use  the more standard 'chat' interface, which follows the openai convention and will be mapped seamlessly by AiAgent.

Example using send_messages:

```ruby
ai_agent = AiAgent::Claude.new(timeout: 30)
prompt = "Generate 5 inspirational quotes."
messages = [{ 'role': 'user', 'content': prompt }]
response = ai_agent.send_messages(messages, options: { system: 'Reply only in Spanish.' })
ai_agent.format_response(response)
```

Example using chat:

```ruby
ai_agent = AiAgent::Claude.new(timeout: 30)
prompt = "Generate 5 inspirational quotes."
messages = [{ 'role': 'system', 'content': 'Reply only in Spanish' }, { 'role': 'user', 'content': prompt }]
response = ai_agent.chat(messages, options: {})
ai_agent.format_response(response)
```

## Prepared prompts

Sentiment analysis:
```ruby
ai_agent = AiAgent::Claude.new
review = "The product quality is excellent and the customer service was very helpful!"
response = ai_agent.analyze_sentiment(review, options: { model: Claude::Model::CLAUDE_CHEAPEST })
ai_agent.format_response(response)
```

Named entity recognition:
```ruby
ai_agent = AiAgent::Claude.new
abstract = "Anthropic released Claude 3.5 Sonnet on 21 June 2024."
response = ai_agent.recognize_entities(abstract, options: { model: Claude::Model::CLAUDE_CHEAPEST })
ai_agent.format_response(response)
```

Text summarization:
```ruby
ai_agent = AiAgent::Claude.new
abstract = "A long message" # customise this for your own example
response = ai_agent.summarize_text(abstract, strict: false, options: { model: Claude::Model::CLAUDE_SMARTEST })
ai_agent.format_response(response)
```

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
