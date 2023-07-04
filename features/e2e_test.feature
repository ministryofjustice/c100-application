Feature: Testing C100 end to end

  Background: Bypassing postcode page
    Given I have started an application
    Then I should see "What kind of application do you want to make?"

  Scenario: Child arrangements order (MIAM) (path one: 'Yes' to 'Have you attended a MIAM?')
    When I choose "Child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order"
    Then I should see "Does this application concern a child who is the subject of separate ongoing emergency proceedings, care proceedings or supervision proceedings (or is already the subject of an emergency, care or supervision order)?"
    And I choose "No"
    Then I should see "Attending a Mediation Information and Assessment Meeting (MIAM)"
    And I click the radio button "No"
    And I check "I understand that I have to attend a MIAM or provide a valid reason for not attending."
    And I click the "Continue" button
    Then I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "Yes"
    Then I should see "Have you got a document signed by the mediator?"
    And I choose "No"
    Then I should see "You need to get a document from the mediator"
    Then I click the "Back" link
    And I choose "Yes"
    Then I should see "Upload your MIAM certificate"
    When I upload a document to the MIAM certificate page
    And I click the "Continue" button
    Then I should see "Safety concerns"
    And I click the "Continue" link
    Then I should see "Are the children at risk of being abducted?"
    And I choose "No"
    Then I should see "Do you have any concerns about drug, alcohol or substance abuse?"
    And I choose "No"
    Then I should see "Have the children suffered or are they at risk of suffering domestic or child abuse?"
    And I choose "No"
    Then I should see "Have you suffered or are you at risk of suffering domestic violence or abuse?"
    And I choose "No"
    Then I should see "Do you have any other safety concerns about you or the children?"
    And I choose "No"
    Then I should see "What are you asking the court to decide about the children involved?"
    When I check "Decide who they live with and when"
    And I click the "Continue" button
    Then I should see "What you’re asking the court to decide about the children"
    And I click the "Continue" link
    Then I should see "Going to court"
    And I check "I understand what’s involved if I decide to go to court"
    And I click the "Continue" button
    Then I should see "Alternative ways to reach an agreement"
    And I click the "Continue" link
    Then I should see "Negotiation tools and services"
    And I choose "Yes"
    Then I should see "Professional mediation"
    And I choose "No"
    Then I should see "Lawyer negotiation"
    And I choose "Yes"
    Then I should see "Collaborative law"
    And I choose "Yes"
    Then I should see "Enter the names of the children"
    And I fill in "First name(s)" with "Jane"
    And I fill in "Last name(s)" with "Doe Jnr"
    And I click the "Continue" button
    Then I should see "Provide details for Jane Doe Jnr"
    And I enter the date 1-1-2023
    And I choose "Female"
    Then I should see "Which of the decisions you’re asking the court to resolve relate to Jane Doe Jnr?"
    And I check "Decide who they live with and when"
    And I click the "Continue" button
    Then I should see "Is there a Special Guardianship Order in force in relation to Jane Doe Jnr?"
    And I choose "No"
    Then I should see "Parental responsibility for Jane Doe Jnr"
    And I fill in "State everyone who has parental responsibility for Jane Doe Jnr and how they have parental responsibility." with "Mother"
    And I click the "Continue" button
    Then I should see "Further information"
#    And I click the radio button "No"

  Scenario: Child arrangements order (MIAM) (path two: 'No' to 'Have you attended a MIAM?')
    When I choose "Child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order"
    Then I should see "Does this application concern a child who is the subject of separate ongoing emergency proceedings, care proceedings or supervision proceedings (or is already the subject of an emergency, care or supervision order)?"
    And I choose "No"
    Then I should see "Attending a Mediation Information and Assessment Meeting (MIAM)"
    And I click the radio button "No"
    And I check "I understand that I have to attend a MIAM or provide a valid reason for not attending."
    And I click the "Continue" button
    Then I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "No"
    Then I should see "Has a mediator confirmed that you do not need to attend a MIAM?"
    And I choose "Yes"
    Then I should see "Have you got a document signed by the mediator?"
    And I choose "Yes"
    Then I should see "Upload your MIAM certificate"
    When I upload a document to the MIAM certificate page
    And I click the "Continue" button
    Then I should see "Safety concerns"

#  Scenario: Consent order