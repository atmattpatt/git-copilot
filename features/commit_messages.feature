Feature: Commit message templates

  Scenario: Working solo
    Given an existing configuration file
    When I run `git-copilot solo`
    Then a commit message template should exist with content
      """
      # Write your commit message here
      """
    And git should use the message template
    And the output should say "working solo"

  Scenario: Working with a single pair
    Given an existing configuration file
    And an existing user "george"
    When I run `git-copilot pair george`
    Then a commit message template should exist with content
      """
      # Write your commit message here

      Co-authored-by: George Smith <george.smith@example.com>
      """
    And git should use the message template
    And the output should say "working with 1 pair"
    And the output should say "George Smith <george.smith@example.com>"

  Scenario: Working with multiple pairs
    Given an existing configuration file
    And an existing user "jake"
    And an existing user "george"
    When I run `git-copilot pair jake george`
    Then a commit message template should exist with content
      """
      # Write your commit message here

      Co-authored-by: Jake Smith <jake.smith@example.com>
      Co-authored-by: George Smith <george.smith@example.com>
      """
    And git should use the message template
    And the output should say "working with 2 pairs"
    And the output should say "Jake Smith <jake.smith@example.com>"
    And the output should say "George Smith <george.smith@example.com>"

  Scenario: Pairing with an invalid user
    Given an empty user set
    And an existing user "george"
    When I run `git-copilot pair jake george`
    Then a commit message template should exist with content
      """
      # Write your commit message here

      Co-authored-by: George Smith <george.smith@example.com>
      """
    And the output should say "Unknown user jake"

  Scenario: Pairing without any users
    Given an empty user set
    And an existing user "george"
    When I run `git-copilot pair`
    Then the output should say "No users to pair with"
