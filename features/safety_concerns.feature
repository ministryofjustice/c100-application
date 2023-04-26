Feature: Safety Concerns
  Background:
    Given I have started an application
    When I visit "steps/safety_questions/start"
    Then I should see "Safety concerns"
    And I click the "Continue" link

  @happy_path
  Scenario: Children Safety Concerns
    Then I should see "Are the children at risk of being abducted?"
    And I choose "Yes"

    Then I should see "Have the police been notified?"
    And I choose "Yes"

    Then I should see "Do any of the children have a passport?"
    And I choose "Yes"

    Then I should see "Provide details of the children’s passports"
    Then I should see "Do the children have more than one passport?"
    And I click the radio button "No"
    And I check "Mother"
    And I click the "Continue" button

    Then I should see "Have the children been abducted or kept outside the UK without your consent before?"
    And I choose "No"

    Then I should see "Why do you think the children may be abducted or kept outside the UK without your consent?"
    And I fill in "Briefly explain your concerns about abduction" with "Own Concerns"
    And I fill in "Where are the children now?" with "England"
    And I click the "Continue" button

    Then I should see "Do you have any concerns about drug, alcohol or substance abuse?"
    And I choose "No"

    Then I should see "You and the children"
    And I click the "Continue" link

    Then I should see "The children’s safety"
    And I click the "Continue" link

    Then I should see "Have the children ever been sexually abused?"
    And I choose "No"

    Then I should see "Have the children ever been physically abused?"
    And I choose "No"

    Then I should see "Have the children ever been financially abused?"
    And I choose "No"

    Then I should see "Have the children ever been psychologically abused?"
    And I choose "No"

    Then I should see "Have the children ever been emotionally abused?"
    And I choose "No"

    Then I should see "Do you have any other safety or welfare concerns about the children?"
    And I choose "No"

    Then I should see "Your safety"

  Scenario: Children Safety Concerns (several concerns)
    Then I should see "Are the children at risk of being abducted?"
    And I choose "No"

    Then I should see "Do you have any concerns about drug, alcohol or substance abuse?"
    And I choose "Yes" and fill in "Give a short description of the drug, alcohol or substance abuse" with "Drugs are bad!"

    Then I should see "You and the children"
    And I click the "Continue" link

    Then I should see "The children’s safety"
    And I click the "Continue" link

    Then I should see "Have the children ever been sexually abused?"
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
    And I should see "Have the children ever been physically abused?"
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
    And I should see "Have the children ever been financially abused?"
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
    And I should see "Have the children ever been psychologically abused?"
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
    And I should see "Have the children ever been emotionally abused?"
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