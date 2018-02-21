# frozen_string_literal: true

Then("git should use the message template") do
  template = `git config commit.template`.strip
  expect(template).to eq(commit_message_template_path)
end

Then("a global git {string} alias should be configured") do |string|
  global_aliases = Open3.capture2e(
    { "HOME" => config_path },
    "git",
    "config",
    "--global",
    "--list",
  ).compact
  expect(global_aliases).to include("alias.#{string}=!git-copilot\n")
end
