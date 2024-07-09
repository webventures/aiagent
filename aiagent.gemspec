# frozen_string_literal: true

require_relative "lib/ai_agent/ruby/version"

Gem::Specification.new do |spec|
  spec.name = "aiagent"
  spec.version = AiAgent::Ruby::VERSION
  spec.authors = ["Web Ventures Ltd"]
  spec.email = ["webven@mailgab.com"]

  spec.summary     = "An interface for interacting with AI Agents such as ChatGPT, Claude, Gemini, LeChat, Ollama."
  spec.description = 'AiAgent provides a common way to interact with the APIs provided by OpenAI, Anthropic, and other AI assistants.'
  spec.homepage = "https://github.com/webventures/aiagent.git"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/webventures/aiagent.git"
  spec.metadata["changelog_uri"] = "https://github.com/webventures/aiagent/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
