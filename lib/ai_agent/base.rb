require 'httparty'
require 'json'

module AiAgent
  class Base
    attr_accessor :agent
    attr_accessor :api_key
    attr_accessor :endpoint
    attr_accessor :timeout

    def initialize
      # be sure to set agent in the subclass initialize method
    end

    def client
      raise NotImplementedError, "Subclasses must implement the client method"
    end

    # messages should be an array of hashes, where each hash contains role and content.
    # role can be 'system', 'assistant', or 'user'.
    # e.g. [{ 'role': 'system', 'content': 'You are a helpful assistant' }, { 'role': 'user', 'content': 'Tell me a joke' }]
    def chat(messages, options: {})
      raise NotImplementedError, "Subclasses must implement the chat (completions) method"
    end

    def format_response(response)
      raise NotImplementedError, "Subclasses must implement the format_response method"
    end

    def analyze_sentiment(text, strict: true, options: {})
      prompt = "Analyze the sentiment of the following text and classify it as positive, negative, or neutral:\n\n#{text}\n\nSentiment: "
      messages = [{ 'role': 'user', 'content': prompt }]
      system = options.delete(:system)
      if strict
        system = ["If you are asked to return a word, then return only that word with no preamble or postamble.", system].compact.join(' ')
        messages.prepend({ 'role': 'system', 'content': system })
        max_tokens = 2
      else
        max_tokens = 100
      end

      chat(messages, options: options.reverse_merge( max_tokens: max_tokens ))
    end

    def recognize_entities(text, strict: true, options: {})
      prompt = "Identify and list the named entities in the following text:\n\n#{text}\n\nEntities: "
      messages = [{ 'role': 'user', 'content': prompt }]
      system = options.delete(:system)
      if strict
        system = ["Be specific in your answer, with no preamble or postamble. If you are asked to list some names, then return only a list of those names, nothing else. ", system].compact.join(' ')
        messages.prepend({ 'role': 'system', 'content': system })
        max_tokens = 100
      else
        max_tokens = 500
      end

      chat(messages, options: options.reverse_merge( max_tokens: max_tokens ))
    end

    def summarize_text(text, strict: true, options: {})
      prompt = "Summarize the following text:\n\n#{text}\n\nSummary: "
      messages = [{ 'role': 'user', 'content': prompt }]
      system = options.delete(:system)
      if strict
        system = ["Be specific in your answer, with no preamble or postamble. I.e. return only what the user asks for, nothing else. ", system].compact.join(' ')
        messages.prepend({ 'role': 'system', 'content': system })
        max_tokens = 100
      else
        max_tokens = 500
      end

      chat(messages, options: options.reverse_merge( max_tokens: max_tokens ))
    end
  end
end
