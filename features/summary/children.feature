Feature: Summary children section
  Scenario: with multiple relationships
    Given I have started an application
    And I have selected orders for the court to decide
    And I enter multiple "children" with names "John" "Doe Junior" and "Samantha" "Doe"
    And I provide details for the child
    And I provide details for the child

    Then I enter multiple "applicant" with names "John" "Doe Senior" and "Samantha" "Brent"
    
    And I provide details for the person
    Then I choose "Father"
    And I click the "Continue" button
    Then I choose "Father"
    And I click the "Continue" button
    Then I provide an applicant's address and contact details

    Then I provide details for the person
    Then I choose "Mother"
    And I click the "Continue" button
    Then I choose "Mother"
    And I click the "Continue" button
    Then I provide an applicant's address and contact details

    Then I enter multiple "respondent" with names "Ben" "Pratchett" and "Bob" "Pratchett"

    And I provide details for the person
    Then I choose "Special Guardian"
    And I click the "Continue" button
    Then I choose "Special Guardian"
    And I click the "Continue" button
    Then I provide a respondent address and contact details

    And I provide details for the person
    Then I choose "Other"
    And I fill in "Please specify" with "Carer"
    And I click the "Continue" button
    Then I choose "Other"
    And I fill in "Please specify" with "Carer"
    And I click the "Continue" button
    Then I provide a respondent address and contact details

    # Is there anyone else who should know about your application?
    Then I choose "Yes"
    And I click the "Continue" button

    Then I enter multiple "other_party" with names "Granny" "Smith" and "Grampy" "Smith"
    Then I provide details for the other party
    Then I choose "Special Guardian"
    And I click the "Continue" button
    Then I choose "Special Guardian"
    And I click the "Continue" button
    Then I provide an other party's address and contact details

    Then I provide details for the other party
    Then I choose "Special Guardian"
    And I click the "Continue" button
    Then I choose "Special Guardian"
    And I click the "Continue" button
    Then I provide an other party's address and contact details

    # Who does child 1 currently live with?
    Then I check "John Doe Senior"
    And I click the "Continue" button

    # Who does child 1 currently live with?
    Then I check "Samantha Brent"
    And I click the "Continue" button
