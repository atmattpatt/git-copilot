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

      solo
    end

    desc "solo", "Prepare a commit message template for solo work"
    def solo
      write_template
      set_git_commit_template
    end

    desc "user SUBCOMMAND", "Manage users that Git Co-pilot knows about"
    subcommand "user", User

    private

    def write_template(authors: [])
      File.write(commit_message_template_path, template(authors: authors))
    end

    def set_git_commit_template
      `git config commit.template #{commit_message_template_path}`
    end

    def template(authors: [])
      coauthored_by_lines = authors.map do |user|
        format("Co-authored-by: %{name} <%{email}>", name: user.name, email: user.email)
      end.join("\n")

      format(configuration["template"], coauthors: coauthored_by_lines)
    end

    def empty_configuration
      YAML.dump(
        "template" => "# Write your commit message here\n\n%{coauthors}",
        "users" => {},
      )
    end
  end
end
