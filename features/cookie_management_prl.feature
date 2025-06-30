Feature: Cookie management PRL
  Background:
    # Simply go to the home page and on to cookies
    Given Opening changes apply
    Given I am on the home page
    When I click the radio button "Start a new application"
    When I fill in "Enter the children's postcode" with "MK9 3DX"
    And I click the "Continue" button
    And I click the "Continue" link
    When I click the "Cookies" link

  Scenario: View cookie management page
    Then I am on the Cookie management page
    And the opening changes end

  Scenario: Cookie management page default preferences
    Then the analytics cookies radio buttons are defaulted to 'No'
    And analytics cookies are NOT allowed to be set
    And the opening changes end

  Scenario: Allowing analytics cookies on the cookie management page
    When I select 'Yes' for analytics cookies
    And I click the Save cookie settings button
    Then google analytics cookies are allowed to be set
    And I see the confirmation message
    And the analytics cookies radio buttons are defaulted to 'Yes'
    And the opening changes end

  Scenario: Not allowing analytics cookies on the cookie management page
    When I select 'No' for analytics cookies
    And I click the Save cookie settings button
    Then analytics cookies are NOT allowed to be set
    And I see the confirmation message
    And the analytics cookies radio buttons are defaulted to 'No'
    And the opening changes end


