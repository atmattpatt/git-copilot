# frozen_string_literal: true

module Git::Copilot
  class CLI < Thor
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

    private

    def config_dir
      File.expand_path(ENV["HOME"])
    end

    def config_file_path
      File.join(config_dir, ".gitcopilot.yml")
    end

    def commit_message_template_path
      File.join(config_dir, ".gitcopilot-commit-template")
    end

    def empty_configuration
      YAML.dump(
        "template" => "# Write your commit message here\n\n%{coauthors}",
        "users" => {},
      )
    end
  end
end
