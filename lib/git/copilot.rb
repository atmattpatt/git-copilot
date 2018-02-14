# frozen_string_literal: true

require "thor"
require "yaml"

# TODO: Remove this
if ENV["COVERAGE"] == "1"
  require "securerandom"
  require "simplecov"
  SimpleCov.command_name "git-copilot-#{SecureRandom.hex(4)}"
  SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
  SimpleCov.start
end

# rubocop:disable Style/ClassAndModuleChildren
module Git
  module Copilot
  end
end
# rubocop:enable Style/ClassAndModuleChildren

require "git/copilot/cli"
require "git/copilot/version"
