# frozen_string_literal: true

module Git::Copilot::Configuration
  User = Struct.new(:username, :name, :email)
  class User
    def to_committer
      format "%{name} <%{email}>", name: name, email: email
    end

    def to_h
      {
        "name" => name,
        "email" => email,
      }
    end
  end

  protected

  def config_dir
    File.expand_path(ENV["HOME"])
  end

  def config_file_path
    File.join(config_dir, ".gitcopilot.yml")
  end

  def commit_message_template_path
    File.join(config_dir, ".gitcopilot-commit-template")
  end

  def configuration
    @configuration ||= YAML.safe_load(File.read(config_file_path))
  end

  def config_to_commit
    {
      "template" => configuration["template"],
      "users" => users.each_with_object({}) do |(username, user), memo|
        memo[username.to_s] = user.to_h
      end,
    }
  end

  def commit_config
    File.write(config_file_path, YAML.dump(config_to_commit))
  end

  def users
    @users ||= configuration.fetch("users", {}).each_with_object({}) do |(username, data), memo|
      memo[username] = User.new(username, data["name"], data["email"])
    end
  end

  def add_user(username, name, email)
    user = User.new(username, name, email)
    users.store(user.username, user)
  end
end
