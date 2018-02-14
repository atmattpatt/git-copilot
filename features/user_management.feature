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
    Given an existing user "george"
    When I run `git-copilot user remove george`
    Then `git-copilot user list` should not include "jake\s+Jake Johnson <jake.johnson@example.com>"
