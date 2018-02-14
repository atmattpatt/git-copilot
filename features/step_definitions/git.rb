Then("git should use the message template") do
  template = `git config commit.template`.strip
  expect(template).to eq(commit_message_template_path)
end
