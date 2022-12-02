Feature: As a user on the postcode page, I want to be able to enter a postcode for the address of the children.

  Background: Navigating to the “Where do the children live” page
  Given I am on the “Where do the children live?” page

  Scenario: Opening the “Where do the children live” page
    Then I should see the complete “Where do the children live?” page

  Scenario: Entering a postcode with no space
    When I fill in "Postcode" with "SW1A2AA"
    And I click the continue button
    Then I should see the “What kind of application do you want to make?” page

  Scenario: Entering a postcode with a space
    When I fill in "Postcode" with "SW1A 2AA"
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
    When I fill in "Postcode" with "EH1 2NG"
    And I click the continue button
    Then I should see the “Sorry, you cannot apply online” page

  Scenario: Invalid postcode submission
    When I fill in "Postcode" with "Invalid postcode"
    And I click the continue button
    Then I should see the invalid postcode error message

  Scenario: Timeout error
    When I fill in "Postcode" with "SW1A 2AA"
    And I wait for a long time
    And I click the continue button
    Then I should see the “What kind of application do you want to make?” page

  Scenario: Postcode not recognised
    Given I stub fact api call to test
    When I fill in "Postcode" with "TQ121XX"
    And I click the continue button
    Then I should see "Something went wrong"
    And I should see a "Download the form (PDF)" link to "https://formfinder.hmctsformfinder.justice.gov.uk/c100-eng.pdf"
    And I should see a "Go back and try again" link to "/steps/opening/postcode"

