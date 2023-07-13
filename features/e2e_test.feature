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
    And I fill in "State everyone who has parental responsibility for Jane Doe Jnr and how they have parental responsibility." with "Father"
    And I click the "Continue" button
    Then I should see "Further information"
    And I choose "Don't know" for all options on this page
    Then I should see "Do you or any respondents have other children who are not part of this application?"
    And I choose "No"
    Then I should see "Enter your name"
    And I fill in "First name(s)" with "John"
    And I fill in "Last name(s)" with "Doe"
    And I click the "Continue" button
    Then I should see "Keeping your contact details private"
    And I choose "I don't know"
    Then I should see "Keeping your contact details private"
    And I choose "No"
    Then I should see "The court will not keep your contact details private"
    And I click the "Continue" link
    Then I should see "Provide details for John Doe"
    And I click the radio button "No"
    And I click the radio button "Male"
    And I enter the date 1-1-1990
    And I fill in "Your place of birth" with "London"
    And I click the "Continue" button
    Then I should see "What is John Doe's relationship to Jane Doe Jnr?"
    And I choose "Father"
    Then I should see "Address of John Doe"
    And I click the "I live outside the UK" link
    And I should see "Address details of John Doe"
    And I fill in "Building and street" with "Buckingham Palace"
    And I fill in "Town or city" with "London"
    And I fill in "Country" with "United Kingdom"
    And I fill in "Postcode" with "SW1A 1AA"
    And I choose "Yes"
    Then I should see "Contact details of John Doe"
    And I click the radio button "I can provide an email address"
    And I fill in "Your email address" with "john@gmail.com"
    And I fill in "Your home phone" with "00000000000"
    And I click the radio button "I can provide a mobile phone number"
    And I fill in "Your mobile phone" with "00000000000"
    And I click the radio button "Yes, the court can leave me a voicemail"
    And I click the "Continue" button
    Then I should see "Will you be legally represented by a solicitor in these proceedings?"
    And I choose "Yes"
    Then I should see "Details of solicitor"
    And I fill in "Full name" with "Annalise Keating"
    And I fill in "Name of firm" with "Keating Law"
    And I fill in "Solicitor’s reference" with "123456"
    And I click the "Continue" button
    Then I should see "Address details of Annalise Keating"
    And I fill in "Building and street" with "Windsor Castle"
    And I fill in "Town or city" with "Windsor"
    And I fill in "Country" with "United Kingdom"
    And I fill in "Postcode" with "SL4 1QF"
    And I click the "Continue" button
    Then I should see "Contact details of Annalise Keating"
    And I fill in "Email address" with "annalise@law.com"
    And I fill in "Phone number" with "00000000000"
    And I fill in "Fax number" with "00000000000"
    And I fill in "DX number" with "00000000000"
    And I click the "Continue" button
    Then I should see "Enter the respondent’s name"
    And I fill in "First name(s)" with "Jane"
    And I fill in "Last name(s)" with "Doe"
    And I click the "Continue" button
    Then I should see "Provide details for Jane Doe"
    And I click the radio button "No"
    And I click the radio button "Female"
    And I enter the date 1-1-1991
    And I fill in "Place of birth" with "London"
    And I click the "Continue" button
    Then I should see "What is Jane Doe's relationship to Jane Doe Jnr?"
    And I choose "Mother"
    Then I should see "Address of Jane Doe"
    And I click the "I don’t know their postcode or they live outside the UK" link
    Then I should see "Address details of Jane Doe"
    And I fill in "Building and street" with "Windsor Castle"
    And I fill in "Town or city" with "Windsor"
    And I fill in "Country" with "United Kingdom"
    And I fill in "Postcode" with "SL4 1QF"
    And I click the radio button "Yes"
    And I click the "Continue" button
    Then I should see "Contact details of Jane Doe"

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