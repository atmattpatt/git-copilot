# frozen_string_literal: true

def run_git_copilot(*args, **opts)
  @output, status = Open3.capture2e(
    { "HOME" => config_path, "COVERAGE" => "1" },
    git_copilot_bin,
    *args,
    **opts,
  )

  puts @output.lines.reject { |line| line =~ /Coverage report generated/ }.join
  puts

  raise "Failed to run `git-copilot #{args.join(' ')}`" unless status.success?
end

When(/I run `git co-pilot init( --force)?`/) do |*args|
  run_git_copilot("init", *args.compact.map(&:strip), stdin_data: "y\n")
end

When(/I run `git-copilot user add( --github)?( .*)`/) do |*args|
  pending if args.include?(" --github")
  run_git_copilot("user", "add", *args.compact.map(&:strip), stdin_data: "#{@name_to_add}\n#{@email_to_add}\n")
end

When(/I run `git-copilot user remove( .*)`/) do |*args|
  run_git_copilot("user", "remove", *args.compact.map(&:strip), stdin_data: "y\n")
end

When("I run `git-copilot user list`") do
  run_git_copilot("user", "list")
end

When("I run `git-copilot solo`") do
  run_git_copilot("solo")
end

When(/I run `git-copilot pair(.*)`/) do |usernames|
  run_git_copilot("pair", *usernames.split(" ").compact)
end

When("I run `git-copilot status`") do
  run_git_copilot("status")
end

Then("the output should say {string}") do |expected|
  expect(@output).to match(Regexp.new(expected))
end

Then("the output should not say {string}") do |expected|
  expect(@output).not_to match(Regexp.new(expected))
end
