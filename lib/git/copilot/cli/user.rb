# frozen_string_literal: true

class Git::Copilot::CLI < Thor
  class User < Thor
    include Git::Copilot::Configuration

    desc "add USERNAME", "Add a user identified by USERNAME"
    def add(username)
      name = ask "Git author name:"
      email = ask "Git author email:"

      user = add_user(username, name, email)
      commit_config

      say %(Added #{user.to_committer} as "#{user.username}")
    end

    desc "list", "List users that Git Co-pilot knows about"
    def list
      return say "No users found" if users.empty?

      user_table = users.map do |username, user|
        [username, user.to_committer]
      end

      print_table user_table
    end
  end
end
