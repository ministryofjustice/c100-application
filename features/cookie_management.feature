Feature: Cookie management
  Background:
    # Simply go to the home page and on to cookies
    # Given Opening changes do not apply
    Given I am on the home page
    # And I click the "Continue" link
    When I click the "Cookies" link

  Scenario: View cookie management page
    Then I am on the Cookie management page

  Scenario: Cookie management page default preferences
    Then the analytics cookies radio buttons are defaulted to 'No'
    And analytics cookies are NOT allowed to be set

  Scenario: Allowing analytics cookies on the cookie management page
    When I select 'Yes' for analytics cookies
    And I click the Save cookie settings button
    Then google analytics cookies are allowed to be set
    And I see the confirmation message
    And the analytics cookies radio buttons are defaulted to 'Yes'

  Scenario: Disallowing analytics cookies on the cookie management page
    When I select 'No' for analytics cookies
    And I click the "Save cookie settings" button
    Then analytics cookies are NOT allowed to be set
    And I see the confirmation message
    And the analytics cookies radio buttons are defaulted to 'No'
