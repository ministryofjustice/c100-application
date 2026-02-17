Feature: Testing the 'Check Your Answers' page

  Background: Advancing to CYA page
    Given I have completed an application
    And Page has title "Check your answers - Apply to court about child arrangements - GOV.UK"
    And I should see "Check your answers"

  @skip
  Scenario: Advancing to CYA page and not filling in Statement of Truth
    When I click the "Submit application" button
    Then I should see "Some information is missing"
    And Page has title "Error: Check your answers - Apply to court about child arrangements - GOV.UK"

  @skip
  Scenario: Advancing to CYA page and not selecting payment details
    When I click the radio button "I believe that the facts stated in this form and any continuation sheet are true"
    And I fill in "Enter your full name" with "Applicant"
    And I click the "Submit application" button
    Then Page has title "Error: Check your answers - Apply to court about child arrangements - GOV.UK"
