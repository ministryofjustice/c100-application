Feature: As a user on the postcode page, I want to be able to enter a postcode for the address of the children.

  Background: Navigating to the “Where do the children live” page
  Given I am on the “Where do the children live?” page

  Scenario: Opening the “Where do the children live” page
    When I am on the “Where do the children live?” page
    Then I should see the complete “Where do the children live?” page

  Scenario: Entering a postcode with no space
    When I enter a postcode with no space
    And I click the continue button
    Then I should see the “What kind of application do you want to make?” page

  Scenario: Entering a postcode with a space
    When I enter a postcode with a space
    And I click the continue button
    Then I should see the “What kind of application do you want to make?” page

  Scenario: Using the back button
    When I click the back button
    Then I should see the home page

  Scenario: Clicking the dropdown
    When I click the “If you do not know where the children live” dropdown
    Then I should see the dropdown text

  Scenario: Empty postcode submission
    When I click the continue button
    Then I should see a full postcode error message

  Scenario: Entering a Scottish postcode
    When I enter a scottish postcode
    And I click the continue button
    Then I should see the “Sorry, you cannot apply online” page

  Scenario: Invalid postcode submission
    When I enter an invalid postcode
    And I click the continue button
    Then I should see the invalid postcode error message

  Scenario: Timeout error
    When I enter a postcode with a space
    And I wait for a long time
    And I click the continue button
    Then I should see the “What kind of application do you want to make?” page
