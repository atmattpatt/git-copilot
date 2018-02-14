Feature: Managing users

  Scenario: Add a user manually
    Given an empty user set
    And I want to add Jake Johnson <jake.johnson@example.com> as "jake"
    When I run `git-copilot user add jake`
    Then `git-copilot user list` should include "jake\s+Jake Johnson <jake.johnson@example.com>"

  Scenario: Add a user from GitHub
    Given an empty user set
    And I want to add Jake Johnson <jake.johnson@example.com> as "jake"
    When I run `git-copilot user add --github jake`
    Then `git-copilot user list` should include "jake\s+Jake Johnson <jake.johnson@example.com>"

  Scenario: Remove a user
    Given an existing user "bo"
    And an existing user "george"
    When I run `git-copilot user remove george`
    Then `git-copilot user list` should include "bo\s+Bo Smith <bo.smith@example.com>"
    And `git-copilot user list` should not include "george\s+George Smith <george.smith@example.com>"

  Scenario: Remove a non-existant user
    Given an empty user set
    When I run `git-copilot user remove george`
    Then the output should say "Unknown user george"
