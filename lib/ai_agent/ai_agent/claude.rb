require "ai_agent/base"
if Gem.loaded_specs.has_key?('claude-ruby')
  require 'claude/client'
else
  Rails.logger.warn "claude-ruby gem is not loaded"
end

module AiAgent
  CLAUDE = 'claude'.freeze

  class Claude < Base
    def initialize
      super
      self.agent = CLAUDE
    end

    def client
      claude if agent == CLAUDE
    end

    def send_messages(messages, options)
      client.messages(messages, options)
    end

    def format_response(response)
      client.parse_response(response) rescue "ERROR: Couldn't extract text from Claude response"
    end

    private

    def claude
      @claude ||= ::Claude::Client.new(anthropic_api_key)
    end

    def anthropic_api_key
      @anthropic_api_key ||= ENV['ANTHROPIC_API_KEY']
    end
  end
end
