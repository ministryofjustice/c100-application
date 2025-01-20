Feature: Cookie management PRL
  Background:
    # Simply go to the home page and on to cookies
    Given Opening changes apply
    Given I am on the home page
    When I click the radio button "Start a new application"
    When I fill in "Enter the children's postcode" with "MK9 3DX"
    And I click the "Continue" button
    And I click the "Continue" link

  Scenario: Cookie management page viewing the basics
    When I click the "Cookies" link
    Then I should see "Essential cookies"
    And I should see "Analytics cookies (optional)"
    And the opening changes end

  Scenario: Default cookie preferences on the cookie management page
    When I click the "Cookies" link
    Then the analytics cookies radio buttons are defaulted to 'No'
    And analytics cookies are NOT allowed to be set
    And the opening changes end

  Scenario: Allowing analytics cookies on the cookie management page
    When I click the "Cookies" link
    When I select 'Yes' for analytics cookies
    And I click the "Save cookie settings" button
    Then google analytics cookies are allowed to be set
    And a confirmation box will appear telling me that my cookie settings have been saved
    And the analytics cookies radio buttons are defaulted to 'Yes'
    And the opening changes end

  Scenario: Not allowing analytics cookies on the cookie management page
    When I click the "Cookies" link
    When I select 'No' for analytics cookies
    And I click the "Save cookie settings" button
    Then analytics cookies are NOT allowed to be set
    And a confirmation box will appear telling me that my cookie settings have been saved
    And the analytics cookies radio buttons are defaulted to 'No'
    And the opening changes end


