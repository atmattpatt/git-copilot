Feature: Current pairing status

  Scenario: Working solo
    Given an existing configuration file
    And I run `git-copilot solo`
    When I run `git-copilot status`
    Then the output should say "working solo"

  Scenario: Working with a single pair
    Given an existing configuration file
    And an existing user "george"
    And I run `git-copilot pair george`
    When I run `git-copilot status`
    Then the output should say "working with 1 pair"
    And the output should say "George Smith <george.smith@example.com>"

  Scenario: Working with multiple pairs
    Given an existing configuration file
    And an existing user "jake"
    And an existing user "george"
    And I run `git-copilot pair jake george`
    When I run `git-copilot status`
    Then the output should say "working with 2 pairs"
    And the output should say "Jake Smith <jake.smith@example.com>"
    And the output should say "George Smith <george.smith@example.com>"

  Scenario: Pairing with an invalid user
    Given an empty user set
    And an existing user "george"
    And I run `git-copilot pair jake george`
    When I run `git-copilot status`
    Then the output should say "working with 1 pair"
    And the output should say "George Smith <george.smith@example.com>"
