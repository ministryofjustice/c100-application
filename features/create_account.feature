Feature: Create account for applicant
  Background:
    Given I have started an application
    And I am on safety concern page

  @happy_path
  Scenario: Applicant create account
    When I create an account
    And I should see "Your application has been saved"

  @happy_path @skip
  Scenario: Login to applicant account
    When I create an account to login
    And I click the "Sign in" link
    And I login
    Then I should see "Your drafts"

  @unhappy_path @skip
  Scenario: Enter no details when on the account creation page
    When I fail to create an account
    Then I should see "Enter your email address"
    Then I should see "Enter a password"

  @unhappy_path @skip
  Scenario: Login to applicant account with no details entered
    When I create an account to login
    And I click the "Sign in" link
    And I click the "Continue" button
    Then I should see "Please enter a valid email and password"
