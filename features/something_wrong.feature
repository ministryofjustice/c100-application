Feature: As a user where something has gone wrong, I should be presented with the Something went wrong page.

  Background: Navigating to the “Something went wrong” page
    Given I am on the “Where do the children live?” page
    And I stub fact api call to test
    And I fill in "Postcode" with "TQ121XX"
    And I click "Continue"

  Scenario: Opening the “Something went wrong” page
    Then I should see the complete “Something went wrong” page

  Scenario: Pressing the back button.
    When I click "Back"
    Then I should see the complete “Where do the children live?” page

  Scenario: Pressing the go back and try again button
    When I click "Go back and try again"
    Then I should see the complete “Where do the children live?” page
