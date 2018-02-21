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

      if yes?("Set up a global git alias? (This will allow you to run `git copilot`)")
        system("git config --global alias.copilot '\!git-copilot'")
      end

      solo
    end

    desc "solo", "Prepare a commit message template for solo work"
    def solo
      clear_pairs
      commit_config
      write_template
      set_git_commit_template
      status
    end

    desc "pair USERNAME...", "Prepare a commit message template for pairing"
    def pair(*usernames)
      authors = usernames.map do |username|
        users.fetch(username) do
          say_status "WARNING", "Unknown user #{username}", :yellow
          next
        end
      end.compact

      if authors.empty?
        return say_status "ERROR", "No users to pair with. " \
          "Did you mean to run git-copilot solo?", :red
      end

      self.current_pairs = authors
      commit_config
      write_template
      set_git_commit_template

      status
    end

    desc "status", "Show the current pairs, if any"
    def status
      if current_pairs.empty?
        say "Now working solo", :green
      else
        say "Now working with #{pluralize_pairs(current_pairs.length)}:"
        current_pairs.each do |author|
          say format("%{name} <%{email}>", name: author.name, email: author.email), :green
        end
      end
    end

    desc "user SUBCOMMAND", "Manage users that Git Co-pilot knows about"
    subcommand "user", User

    private

    def write_template
      File.write(commit_message_template_path, template(authors: current_pairs))
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

    def pluralize_pairs(number)
      number == 1 ? "1 pair" : "#{number} pairs"
    end
  end
end
