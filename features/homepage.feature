Feature: Home page

  Scenario: I want to learn if I can apply for child protection
    When I open the home page
    Then I should see the home page

  Scenario: Start an application
    Given I am on the landing page
    When I click the continue button
    Then  I should see the complete “Where do the children live?” page

  Scenario: Return to an application
    Given I am on the landing page
    When I click “Or return to a saved application”
    Then I should be redirected to “Sign in”

  Scenario: Using the back button
    Given I am on the landing page
    When I click the back button
    Then I am redirected to “Making child arrangements if you divorce or separate”

  Scenario: Timeout error
    Given I am on the landing page
    And I wait for a long time
    When I click the continue button
    Then I should see the complete “Where do the children live?” page
