# frozen_string_literal: true

Given("an empty user set") do
  step "that no configuration exists"
  step "I run `git co-pilot init`"
end

Given(/I want to add ([\w\s]*) <(.*)> as "(\w*)"/) do |name, email, username|
  @name_to_add = name
  @email_to_add = email
  @username_to_add = username
end

Then("`git-copilot user list` should include {string}") do |string|
  step "I run `git-copilot user list`"
  step %(the output should say "#{string}")
end
