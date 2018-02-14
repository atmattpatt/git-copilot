# frozen_string_literal: true

Given("that no configuration exists") do
  FileUtils.rm([config_file_path, commit_message_template_path], force: true)
end

Given("an existing configuration file") do
  configuration = YAML.dump(
    "template" => "# Write your commit message here\n\n%{coauthors}",
    "users" => {
      "jake" => {
        "name" => "Jake Johnson",
        "email" => "jake.johnson@example.com",
      },
    },
  )
  File.write(config_file_path, configuration)
end

Then("a configuration file should exist with YAML content") do |expected|
  expect(File.exist?(config_file_path)).to be_truthy, "Configuration file does not exist"

  file_contents = File.read(config_file_path)
  expect(YAML.safe_load(file_contents)).to be_truthy, "Configuration file is not valid YAML"
  expect(file_contents.strip).to eq(expected.strip)
end

Then("a commit message template should exist with content") do |expected|
  expect(File.exist?(commit_message_template_path)).to be_truthy, "Commit message template does not exist"

  file_contents = File.read(commit_message_template_path)
  expect(file_contents.strip).to eq(expected.strip)
end
