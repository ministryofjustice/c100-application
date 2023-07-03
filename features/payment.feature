Feature: Testing payment feature pages beyond the 'Check Your Answers' page

  Scenario:
    Given I have completed an application
    And Page has title "Check your answers - Apply to court about child arrangements - GOV.UK"
    And I should see "Check your answers"
    # step to fill in truth statement and then submit application
    And I click the "Submit application" button


