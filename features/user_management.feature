Feature: Managing users

  Scenario: Add a user manually
    Given an empty user set
    And I want to add Jake Johnson <jake.johnson@example.com> as "jake"
    When I run `git-copilot user add`
    Then `git-copilot user list` should include "jake\s+Jake Johnson <jake.johnson@example.com>"
