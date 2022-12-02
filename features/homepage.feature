Feature: Home page

  Background: Navigating to the “Landing” page
    Given I open the home page

  Scenario: I want to learn if I can apply for child protection
    Then I should see the home page

  Scenario: Start an application
    When I click "Continue"
    Then  I should see the complete “Where do the children live?” page

  Scenario: Return to an application
    When I click "Or return to a saved application"
    Then I should be redirected to “Sign in”

  Scenario: Using the back button
    When I click "Back"
    Then I am redirected to “Making child arrangements if you divorce or separate”

  Scenario: Timeout error
    And I wait for a long time
    When I click "Continue"
    Then I should see the complete “Where do the children live?” page
