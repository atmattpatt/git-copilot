Feature: Initialization

  Scenario: Initializing git-copilot for the first time
    Given that no configuration exists
    When I run `git co-pilot init`
    Then a configuration file should exist with YAML content
      """
      ---
      template: |-
        # Write your commit message here

        %{coauthors}
      users: {}
      """
    And a commit message template should exist with content
      """
      # Write your commit message here
      """

  Scenario: Initializing git-copilot when a configuration file already exists
    Given an existing configuration file
    When I run `git co-pilot init`
    Then the output should say "Configuration file already exists"

  Scenario: Force-initializing git-copilot when a configuration file already exists
    Given an existing configuration file
    When I run `git co-pilot init --force`
    Then a configuration file should exist with YAML content
      """
      ---
      template: |-
        # Write your commit message here

        %{coauthors}
      users: {}
      """
    And a commit message template should exist with content
      """
      # Write your commit message here
      """
