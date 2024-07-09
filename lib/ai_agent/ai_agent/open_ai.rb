require "ai_agent/base"
if Gem.loaded_specs.has_key?('ruby-openai')
  # require 'ruby-openai'
else
  Rails.logger.warn "ruby-openai gem is not loaded"
end

module AiAgent
  OPENAI = 'openai'.freeze

  class OpenAI < Base
    module Model
      GPT_4O = 'gpt-4o'
      GPT_4_TURBO = 'gpt-4-turbo'
      GPT_4 = 'gpt-4'
      GPT_3_5_TURBO= 'gpt-3.5-turbo'
    end

    def initialize(api_key: nil, endpoint: nil, timeout: 60)
      self.agent = OPENAI
      self.api_key = api_key || ENV['OPENAI_API_KEY']
      self.endpoint = endpoint # nil for default as defined in openai/client
      self.timeout = timeout
    end

    def client
      openai if agent == OPENAI
    end

    def chat(messages, options: {})
      params = options.reverse_merge(model: Model::GPT_4O, temperature: 0.1)
      client.chat(parameters: params.merge(messages: messages))
    end

    def format_response(response)
      response['choices'][0]['message']['content'] rescue "ERROR: Couldn't extract text from OpenAI response"
    end

    private

    def openai
      @openai ||= ::OpenAI::Client.new(access_token: api_key, uri_base: endpoint, request_timeout: timeout)
    end
  end
end
