# frozen_string_literal: true

require "git/copilot/configuration"
require "git/copilot/cli/user"

module Git::Copilot
  class CLI < Thor
    include Configuration

    desc "init", "Initialize Git Co-pilot"
    option :force, aliases: [:f], type: :boolean, desc: "Overwrite existing configuration files"
    def init
      if File.exist?(config_file_path) && !options[:force]
        return say_status "ERROR", "Configuration file already exists", :red
      end

      say "Writing configuration file to #{config_file_path}"
      File.write(config_file_path, empty_configuration)

      # TODO: Replace with solo
      File.write(commit_message_template_path, "# Write your commit message here")
    end

    desc "user SUBCOMMAND", "Manage users that Git Co-pilot knows about"
    subcommand "user", User

    private

    def empty_configuration
      YAML.dump(
        "template" => "# Write your commit message here\n\n%{coauthors}",
        "users" => {},
      )
    end
  end
end
