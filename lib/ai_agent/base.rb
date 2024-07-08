require 'httparty'
require 'json'

module AiAgent
  class Base
    attr_accessor :agent

    def initialize
      # be sure to set agent in the subclass initialize method
    end

    def client
      raise NotImplementedError, "Subclasses must implement the client method"
    end

    def send_messages(messages, options)
      raise NotImplementedError, "Subclasses must implement the send_message method"
    end

    def format_response(response)
      raise NotImplementedError, "Subclasses must implement the format_response method"
    end

    def analyze_sentiment(text, strict: true, options: {})
      prompt = "Analyze the sentiment of the following text and classify it as positive, negative, or neutral:\n\n#{text}\n\nSentiment: "
      if strict
        system = "If you are asked to return a word, then return only that word with no preamble or postamble. " if strict
        max_tokens = 2
      else
        max_tokens = 100
      end

      send_messages([ { 'role': 'user', 'content': prompt } ],
                    options.reverse_merge( system: system, max_tokens: max_tokens ))
    end

    def recognize_entities(text, strict: true, options: {})
      prompt = "Identify and list the named entities in the following text:\n\n#{text}\n\nEntities: "
      if strict
        system = "Be specific in your answer, with no preamble or postamble. If you are asked to list some names, then return only a list of those names, nothing else. "
        max_tokens = 100
      else
        max_tokens = 500
      end

      send_messages([ { 'role': 'user', 'content': prompt } ],
                    options.reverse_merge( system: system, max_tokens: max_tokens ))
    end

    def summarize_text(text, strict: true, options: {})
      prompt = "Summarize the following text:\n\n#{text}\n\nSummary: "
      if strict
        system = "Be specific in your answer, with no preamble or postamble. I.e. return only what the user asks for, nothing else. "
        max_tokens = 100
      else
        max_tokens = 500
      end

      send_messages([ { 'role': 'user', 'content': prompt } ],
                    options.reverse_merge( system: system, max_tokens: max_tokens ))
    end
  end
end
