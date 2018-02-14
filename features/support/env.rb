# frozen_string_literal: true

require "fileutils"
require "open3"
require "simplecov"

SimpleCov.start do
  add_filter "/features/"
  add_filter "/spec/"
end

Before do
  FileUtils.rm([config_file_path, commit_message_template_path], force: true)
end

def git_copilot_bin
  File.expand_path("../../../bin/git-copilot", __FILE__)
end

def config_path
  File.expand_path("../../../tmp", __FILE__)
end

def config_file_path
  File.join(config_path, ".gitcopilot.yml")
end

def commit_message_template_path
  File.join(config_path, ".gitcopilot-commit-template")
end
