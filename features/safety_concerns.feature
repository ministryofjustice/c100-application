Feature: Safety Concerns
  Background:
    Given I have started an application
    When I navigate to the Safety concerns from consent order page
    And I click the "Continue" link

  @happy_path
  Scenario: Children Safety Concerns
    Then I should see "Are the children at risk of being abducted?"

    # Provoke validation error
    Then I click the "Continue" button
    And I should see a "Select yes if the children are at risk of being abducted" link to "#steps-safety-questions-risk-of-abduction-form-risk-of-abduction-field-error"

    # Fixing validation error
    When I choose "Yes"
    Then I should see "Have the police been notified?"

    # Provoke validation error
    When I click the "Continue" button
    Then I should see a "Select yes if the police have been notified" link to "#steps-abduction-international-form-passport-office-notified-field-error"

    # Fixing validation error
    When I choose "Yes"
    Then I should see "Do any of the children have a passport?"

    # Provoke validation error
    When I click the "Continue" button
    Then I should see a "Select yes if the children have a passport" link to "#steps-abduction-children-have-passport-form-children-have-passport-field-error"

    # Fixing validation error
    When I choose "Yes"
    Then I should see "Provide details of the children’s passports"
    And I should see "Do the children have more than one passport?"

    # Provoking validation error
    When I click the "Continue" button
    Then I should see a "Select yes if they have more than one passport" link to "#steps-abduction-passport-details-form-children-multiple-passports-field-error"

    # Fixing validation error
    When I click the radio button "No"
    Then I check "Mother"
    And I click the "Continue" button
    Then I should see "Have the children been abducted or kept outside the UK without your consent before?"

    # Provoking validation error
    When I click the "Continue" button
    Then I should see a "Select yes if the children have been abducted before" link to "#steps-abduction-previous-attempt-form-previous-attempt-field-error"

    # Fixing validation error
    When I choose "No"
    Then I should see "Why do you think the children may be abducted or kept outside the UK without your consent?"

    # Provoking validation error
    When I click the "Continue" button
    Then I should see a "Enter details of your concerns" link to "#steps-abduction-risk-details-form-risk-details-field-error"
    And I should see a "Enter where the children are now" link to "#steps-abduction-risk-details-form-current-location-field-error"

    # Fixing validation error
    When I fill in "Briefly explain your concerns about abduction" with "Own Concerns"
    And I fill in "Where are the children now?" with "England"
    And I click the "Continue" button
    Then I should see "Do you have any concerns about drug, alcohol or substance abuse?"

    # Provoking validation error
    When I click the "Continue" button
    Then I should see a "Select yes if you have concerns about drug, alcohol or substance abuse" link to "#steps-safety-questions-substance-abuse-form-substance-abuse-field-error"

    # Fixing validation error and continuing
    When I choose "No"
    Then I should see "You and the children"
    And I click the "Continue" link
    Then I should see "The children’s safety"
    And I click the "Continue" link
    Then I should see "Have the children ever been sexually abused by the respondent?"

    # Provoking validation error
    When I click the "Continue" button
    Then I should see a "Select yes if this safety concern applies" link to "#steps-abuse-concerns-question-form-answer-field-error"

    # Fixing validation error
    When I choose "No"
    Then I should see "Have the children ever been physically abused by the respondent?"

    # Provoking validation error
    When I click the "Continue" button
    Then I should see a "Select yes if this safety concern applies" link to "#steps-abuse-concerns-question-form-answer-field-error"

    # Fixing validation error
    When I choose "No"
    Then I should see "Have the children ever been financially abused by the respondent?"

    # Provoking validation error
    When I click the "Continue" button
    Then I should see a "Select yes if this safety concern applies" link to "#steps-abuse-concerns-question-form-answer-field-error"

    # Fixing validation error
    When I choose "No"
    Then I should see "Have the children ever been psychologically abused by the respondent?"

    # Provoking validation error
    When I click the "Continue" button
    Then I should see a "Select yes if this safety concern applies" link to "#steps-abuse-concerns-question-form-answer-field-error"

    # Fixing validation error
    When I choose "No"
    Then I should see "Have the children ever been emotionally abused by the respondent?"

    # Provoking validation error
    When I click the "Continue" button
    Then I should see a "Select yes if this safety concern applies" link to "#steps-abuse-concerns-question-form-answer-field-error"

    # Fixing validation error
    When I choose "No"
    Then I should see "Do you have any other safety or welfare concerns about the children?"

    # Provoking validation error
    When I click the "Continue" button
    Then I should see a "Select yes if this safety concern applies" link to "#steps-abuse-concerns-question-form-answer-field-error"

    # Fixing validation error
    When I choose "No"
    Then I should see "Your safety"

  @happy_path
  Scenario: Children Safety Concerns (several concerns)
    Then I should see "Are the children at risk of being abducted?"
    And I choose "No"

    Then I should see "Do you have any concerns about drug, alcohol or substance abuse?"
    And I choose "Yes" and fill in "Give a short description of the drug, alcohol or substance abuse" with "Drugs are bad!"

    Then I should see "You and the children"
    And I click the "Continue" link

    Then I should see "The children’s safety"
    And I click the "Continue" link

    Then I should see "Have the children ever been sexually abused by the respondent?"
    And I choose "Yes"

    # Provoking validation error
    Then Page has title "About the children’s sexual abuse - Apply to court about child arrangements - GOV.UK"
    And I click the "Continue" button
    Then I should see a "Please briefly describe what happened and who was involved" link to "#steps-abuse-concerns-details-form-behaviour-description-field-error"
    And I should see a "Provide when this behaviour started" link to "#steps-abuse-concerns-details-form-behaviour-start-field-error"
    And I should see a "Provide whether this behaviour still ongoing" link to "#steps-abuse-concerns-details-form-behaviour-ongoing-field-error"
    And I should see a "Provide whether you asked for help" link to "#steps-abuse-concerns-details-form-asked-for-help-field-error"

    # Fixing validation error
    Then I submit the form details for "About the children’s sexual abuse"
    And I should see "Have the children ever been physically abused by the respondent?"
    Then I choose "Yes"

    # Provoking validation error
    Then Page has title "About the children’s physical abuse - Apply to court about child arrangements - GOV.UK"
    And I click the "Continue" button
    Then I should see a "Please briefly describe what happened and who was involved" link to "#steps-abuse-concerns-details-form-behaviour-description-field-error"
    And I should see a "Provide when this behaviour started" link to "#steps-abuse-concerns-details-form-behaviour-start-field-error"
    And I should see a "Provide whether this behaviour still ongoing" link to "#steps-abuse-concerns-details-form-behaviour-ongoing-field-error"
    And I should see a "Provide whether you asked for help" link to "#steps-abuse-concerns-details-form-asked-for-help-field-error"

    # Fixing validation error
    Then I submit the form details for "About the children’s physical abuse"
    And I should see "Have the children ever been financially abused by the respondent?"
    Then I choose "Yes"

    # Provoking validation error
    Then Page has title "About the children’s financial abuse - Apply to court about child arrangements - GOV.UK"
    And I click the "Continue" button
    Then I should see a "Please briefly describe what happened and who was involved" link to "#steps-abuse-concerns-details-form-behaviour-description-field-error"
    And I should see a "Provide when this behaviour started" link to "#steps-abuse-concerns-details-form-behaviour-start-field-error"
    And I should see a "Provide whether this behaviour still ongoing" link to "#steps-abuse-concerns-details-form-behaviour-ongoing-field-error"
    And I should see a "Provide whether you asked for help" link to "#steps-abuse-concerns-details-form-asked-for-help-field-error"

    # Fixing validation error
    Then I submit the form details for "About the children’s financial abuse"
    And I should see "Have the children ever been psychologically abused by the respondent?"
    Then I choose "Yes"

    # Provoking validation error
    Then Page has title "About the children’s psychological abuse - Apply to court about child arrangements - GOV.UK"
    And I click the "Continue" button
    Then I should see a "Please briefly describe what happened and who was involved" link to "#steps-abuse-concerns-details-form-behaviour-description-field-error"
    And I should see a "Provide when this behaviour started" link to "#steps-abuse-concerns-details-form-behaviour-start-field-error"
    And I should see a "Provide whether this behaviour still ongoing" link to "#steps-abuse-concerns-details-form-behaviour-ongoing-field-error"
    And I should see a "Provide whether you asked for help" link to "#steps-abuse-concerns-details-form-asked-for-help-field-error"

    # Fixing validation error
    Then I submit the form details for "About the children’s psychological abuse"
    And I should see "Have the children ever been emotionally abused by the respondent?"
    Then I choose "Yes"

    # Provoking validation error
    Then Page has title "About the children’s emotional abuse - Apply to court about child arrangements - GOV.UK"
    And I click the "Continue" button
    Then I should see a "Please briefly describe what happened and who was involved" link to "#steps-abuse-concerns-details-form-behaviour-description-field-error"
    And I should see a "Provide when this behaviour started" link to "#steps-abuse-concerns-details-form-behaviour-start-field-error"
    And I should see a "Provide whether this behaviour still ongoing" link to "#steps-abuse-concerns-details-form-behaviour-ongoing-field-error"
    And I should see a "Provide whether you asked for help" link to "#steps-abuse-concerns-details-form-asked-for-help-field-error"

    # Fixing validation error
    Then I submit the form details for "About the children’s emotional abuse"
    And I should see "Do you have any other safety or welfare concerns about the children?"
    Then I choose "Yes"

    # Provoking validation error
    Then Page has title "Other concerns about the children - Apply to court about child arrangements - GOV.UK"
    And I click the "Continue" button
    Then I should see a "Please briefly describe what happened and who was involved" link to "#steps-abuse-concerns-details-form-behaviour-description-field-error"
    And I should see a "Provide when this behaviour started" link to "#steps-abuse-concerns-details-form-behaviour-start-field-error"
    And I should see a "Provide whether this behaviour still ongoing" link to "#steps-abuse-concerns-details-form-behaviour-ongoing-field-error"
    And I should see a "Provide whether you asked for help" link to "#steps-abuse-concerns-details-form-asked-for-help-field-error"

    # Fixing validation error
    Then I submit the form details for "Other concerns about the children"
    And I should see "Your safety"


  @happy_path
  Scenario: Testing timeout on children safety concerns
    Then I should see "Are the children at risk of being abducted?"
    And I wait and click the "Continue" button
    Then I should see "Sorry, you'll have to start again"
    And the time goes back to normal
