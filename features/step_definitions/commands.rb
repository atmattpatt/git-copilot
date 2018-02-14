# frozen_string_literal: true

def run_git_copilot(*args)
  @output, status = Open3.capture2e(
    { "HOME" => config_path },
    git_copilot_bin,
    *args,
  )

  raise "Failed to run `git-copilot #{args.join(' ')}`" unless status.success?
end

When(/I run `git co-pilot init( --force)?`/) do |*args|
  run_git_copilot("init", *args.compact.map(&:strip))
end

Then("the output should say {string}") do |expected|
  expect(@output).to match(Regexp.new(expected))
end
