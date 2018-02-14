Feature: Commit message templates

  Scenario: Working solo
    When I run `git-copilot solo`
    Then a commit message template should exist with content
      """
      # Write your commit message here
      """
    And git should use the message template

  Scenario: Working with a single pair
    Given an existing user "george"
    When I run `git-copilot pair george`
    Then a commit message template should exist with content
      """
      # Write your commit message here

      Co-authored-by: George Smith <george.smith@example.com>
      """
    And git should use the message template

  Scenario: Working with multiple pair
    Given an existing user "jake"
    And an existing user "george"
    When I run `git-copilot pair jake george`
    Then a commit message template should exist with content
      """
      # Write your commit message here

      Co-authored-by: Jake Smith <jake.smith@example.com>
      Co-authored-by: George Smith <george.smith@example.com>
      """
    And git should use the message template
