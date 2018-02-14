# frozen_string_literal: true

def run_git_copilot(*args, **opts)
  @output, status = Open3.capture2e(
    { "HOME" => config_path },
    git_copilot_bin,
    *args,
    **opts,
  )

  puts @output
  puts

  raise "Failed to run `git-copilot #{args.join(' ')}`" unless status.success?
end

When(/I run `git co-pilot init( --force)?`/) do |*args|
  run_git_copilot("init", *args.compact.map(&:strip))
end

When("I run `git-copilot user add`") do
  run_git_copilot("user", "add", @username_to_add, stdin_data: "#{@name_to_add}\n#{@email_to_add}\n")
end

When("I run `git-copilot user list`") do
  run_git_copilot("user", "list")
end

Then("the output should say {string}") do |expected|
  expect(@output).to match(Regexp.new(expected))
end
