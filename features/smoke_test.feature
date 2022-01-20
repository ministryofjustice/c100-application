Feature: End to end

  @happy_path
  Scenario: Happy path - child arrangements order
    Given I visit "/"
    And I click the "Continue" link
    Then I should see "Where do the children live?"

    # Where do the children live?
    Then I fill in "Postcode" with "CV21 2AB"
    And I click the "Continue" button
    Then I should see "What kind of application do you want to make?"

    # What kind of application do you want to make?
    Then I click the radio button "Child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order"
    And I click the "Continue" button
    Then I should see "Are the children involved in any emergency protection, care or supervision proceedings (or have they been)?"

    # Are the children involved in any emergency protection, care or supervision proceedings?
    Then I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Attending a Mediation Information and Assessment Meeting (MIAM)"

    # Attending a Mediation Information and Assessment Meeting (MIAM)
    Then I click the radio button "No"
    Then I check "I understand that I have to attend a MIAM or provide a valid reason for not attending."
    And I click the "Continue" button
    Then I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"

    # Have you attended a Mediation Information and Assessment Meeting (MIAM)?
    Then I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Has a mediator confirmed that you do not need to attend a MIAM?"

    # Has a mediator confirmed that you do not need to attend a MIAM?
    Then I click the radio button "Yes"
    And I click the "Continue" button
    Then I should see "Have you got a document signed by the mediator?"

    # Have you got a document signed by the mediator?
    Then I click the radio button "Yes"
    And I click the "Continue" button
    Then I should see "When did you meet with the mediator?"

    # When did you meet with the mediator?
    Then I enter the date 25-05-2020
    And I click the "Continue" button
    Then I should see "Enter mediator details"

    # Enter mediator details
    Then I fill in "Mediator registration number (URN)" with "123"
    And I fill in "Family mediation service name" with "My mediator service"
    And I click the "Continue" button
    Then I should see "Document from the mediator"

    # Document from the mediator
    Then I click the "Continue" link
    Then I should see "Safety concerns"

    # Safety concerns
    Then I click the "Continue" link
    Then I should see "Keeping your contact details private"

    # Keeping your contact details private
    Then I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Are the children at risk of being abducted?"

    # Are the children at risk of being abducted?
    Then I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Do you have any concerns about drug, alcohol or substance abuse?"

    # Do you have any concerns about drug, alcohol or substance abuse?
    Then I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Have the children suffered or are they at risk of suffering domestic or child abuse?"

    # Have the children suffered or are they at risk of suffering domestic or child abuse?
    Then I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Have you suffered or are you at risk of suffering domestic violence or abuse?"

    # Have you suffered or are you at risk of suffering domestic violence or abuse?
    Then I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Do you have any other safety concerns about you or the children?"

    # Do you have any other safety concerns about you or the children?
    Then I click the radio button "No"
    And I click the "Continue" button
    Then I should see "What are you asking the court to decide about the children involved?"

    # What are you asking the court to decide about the children involved?
    Then I check "Decide who they live with and when"
    And I click the "Continue" button
    Then I should see "What you’re asking the court to decide about the children"

    # What you’re asking the court to decide about the children
    Then I click the "Continue" link
    Then I should see "Going to court"

    # Going to court
    Then I check "I understand what’s involved if I decide to go to court"
    And I click the "Continue" button
    Then I should see "Alternative ways to reach an agreement"

    # Alternative ways to reach an agreement
    Then I click the "Continue" link
    Then I should see "Negotiation tools and services"

    # Negotiation tools and services
    Then I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Professional mediation"

    # Professional mediation
    Then I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Lawyer negotiation"

    # Lawyer negotiation
    Then I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Collaborative law"

    # Collaborative law    
    Then I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Enter the names of the children"

    # Enter the names of the children
    Then I fill in "First name(s)" with "John"
    And I fill in "Last name(s)" with "Doe Junior"
    And I click the "Continue" button
    Then I should see "Provide details for John Doe Junior"

    # Provide details for John Doe Junior
    Then I enter the date 25-05-1990
    And I choose "Male"
    And I click the "Continue" button
    Then I should see "Which of the decisions you’re asking the court to resolve relate to John Doe Junior?"

    # Which of the decisions you’re asking the court to resolve relate to John Doe Junior?
    Then I check "Decide who they live with and when"
    And I click the "Continue" button
    Then I should see "Is there a Special Guardianship Order in force in relation to John Doe Junior?"

    # Is there a Special Guardianship Order in force in relation to John Doe Junior?
    Then I choose "No"
    And I click the "Continue" button
    Then I should see "Further information"

    # Further information
    Then I click "No" for the radio button "Are any of the children known to social services?"
    And I click "No" for the radio button "Are any of the children the subject of a child protection plan?"
    And I click the "Continue" button
    Then I should see "Do you or any respondents have other children who are not part of this application?"

    # Do you or any respondents have other children who are not part of this application?
    Then I choose "No"
    And I click the "Continue" button
    Then I should see "You and anyone else making this application are known as the applicants"

    # Enter the applicant’s name
    Then I fill in "First name(s)" with "John"
    And I fill in "Last name(s)" with "Doe Senior"
    And I click the "Continue" button
    Then I should see "Provide details for John Doe Senior"

    # Provide details for John Doe Senior
    Then I click "No" for the radio button "Have you changed your name?"
    And I click "Male" for the radio button "Sex"
    And I enter the date 25-05-1972
    And I fill in "Place of birth" with "London"
    And I click the "Continue" button
    Then I should see "What is John Doe Senior's relationship to John Doe Junior?"

    # What is John Doe Senior's relationship to John Doe Junior?
    Then I choose "Father"
    And I click the "Continue" button
    Then I should see "Address of John Doe Senior"

    # Address of John Doe Senior
    Then I fill in "Current postcode" with "CV21 2AB"
    And I click the "Continue" button
    Then I should see "Select address of John Doe Senior"

    # Select address of John Doe Senior - shows postcode not found
    Then I click the "I can’t find the address in the list" link
    Then I click the "Continue" button
    Then I should see "Address details of John Doe Senior"

    # Address details of John Doe Senior
    Then I fill in "Building and street" with "1 house road"
    And I fill in "Town or city" with "Birmingford"
    And I click "Yes" for the radio button "Have you lived at your current address for more than 5 years?"
    And I click the "Continue" button
    Then I should see "Contact details of John Doe Senior"

    # Contact details of John Doe Senior
    Then I click the radio button "I cannot provide an email address"
    And I fill in "Mobile phone" with "0777 222 2222"
    And I click the radio button "No, the court cannot leave me a voicemail"
    And I click the "Continue" button
    Then I should see "Will you be legally represented by a solicitor in these proceedings?"

    # Will you be legally represented by a solicitor in these proceedings?
    Then I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Enter the respondent’s name"

    # Enter the respondent’s name
    Then I fill in "First name(s)" with "Bob"
    And I fill in "Last name(s)" with "Pratchett"
    And I click the "Continue" button
    Then I should see "Provide details for Bob Pratchett"

    # Provide details for Bob Pratchett
    Then I click "No" for the radio button "Have they changed their name?"
    And I click "Male" for the radio button "Sex"
    And I enter the date 25-05-1972
    And I fill in "Place of birth" with "London"
    And I click the "Continue" button
    Then I should see "What is Bob Pratchett's relationship to John Doe Junior?"

    # What is Bob Pratchett's relationship to John Doe Junior?
    Then I click the radio button "Father"
    And I click the "Continue" button
    Then I should see "Address of Bob Pratchett"
 
    # Address of Bob Pratchett
    Then I fill in "Current postcode" with "CV21 2DE"
    And I click the "Continue" button
    Then I should see "Select address of Bob Pratchett"

    # Select address of Bob Pratchett - shows postcode not found
    Then I click the "I can’t find the address in the list" link
    And I click the "Continue" button
    Then I should see "Address details of Bob Pratchett"

    # Address details of Bob Pratchett
    Then I fill in "Building and street" with "2 house road"
    And I fill in "Town or city" with "Birmingford"
    And I click "Yes" for the radio button "Have they lived at this address for more than 5 years?"
    And I click the "Continue" button
    Then I should see "Contact details of Bob Pratchett"

    # Contact details of Bob Pratchett
    Then I check "I don't know their email"
    And I check "I don't know their home phone"
    And I check "I don't know their mobile number"
    And I click the "Continue" button
    Then I should see "Is there anyone else who should know about your application?"

    # Is there anyone else who should know about your application?
    Then I choose "Yes"
    And I click the "Continue" button
    Then I should see "Enter the other person’s name"

    # Enter the other person’s name
    Then I fill in "First name(s)" with "Granny"
    And I fill in "Last name(s)" with "Smith"
    And I click the "Continue" button
    Then I should see "Provide details for Granny Smith"

    # Provide details for Granny Smith
    Then I click "No" for the radio button "Have they changed their name?"
    And I click "Female" for the radio button "Sex"
    And I enter the date 25-05-1952
    And I click the "Continue" button
    Then I should see "What is Granny Smith's relationship to John Doe Junior?"

    # What is Granny Smith's relationship to John Doe Junior?
    Then I choose "Grandparent"
    And I click the "Continue" button
    Then I should see "Address of Granny Smith"
 
    # Address of Granny Smith
    Then I fill in "Current postcode" with "CV21 2FG"
    And I click the "Continue" button
    Then I should see "Select address of Granny Smith"

    # Select address of Granny Smith - shows postcode not found
    Then I click the "Continue" link
    Then I should see "Address details of Granny Smith"

    # Address details of Granny Smith
    Then I fill in "Building and street" with "3 house road"
    And I fill in "Town or city" with "Birmingford"
    And I click the "Continue" button
    Then I should see "Who does John Doe Junior currently live with?"

    # Who does John Doe Junior currently live with?
    Then I click the radio button "Bob Pratchett"
    And I click the "Continue" button
    Then I should see "Have any of the children in this application been involved in other family court proceedings?"
    
    # Have any of the children in this application been involved in other family court proceedings?
    Then I choose "No"
    And I click the "Continue" button
    Then I should see "Do you need an urgent hearing?"

    # Do you need an urgent hearing?
    Then I choose "No"
    And I click the "Continue" button
    Then I should see "Are you asking for a without notice hearing?"

    # Are you asking for a without notice hearing?
    Then I choose "No"
    And I click the "Continue" button
    Then I should see "Is the life of the child or children, a parent, or anyone significant to the children mainly based in a country outside England or Wales?"

    # Is the life of the child or children, a parent, or anyone significant to the children mainly based in a country outside England or Wales?
    Then I choose "No"
    And I click the "Continue" button
    Then I should see "Do you think another person in this application may be able to apply for a similar order in a country outside England or Wales?"

    # Do you think another person in this application may be able to apply for a similar order in a country outside England or Wales?
    Then I choose "No"
    And I click the "Continue" button
    Then I should see "Has a request for information or other assistance involving the children been made to or by another country?"

    # Has a request for information or other assistance involving the children been made to or by another country?
    Then I choose "No"
    And I click the "Continue" button
    Then I should see "Why are you making this application?"

    # Why are you making this application?        
    Then I fill in "Provide details" with "Change carers for children"
    And I click the "Continue" button
    Then I should see "Are there any factors that may affect any adult in this application taking part in the court proceedings?"

    # Are there any factors that may affect any adult in this application taking part in the court proceedings?
    Then I choose "No"
    And I click the "Continue" button
    Then I should see "Does anyone in this application need an intermediary to help them in court?"

    # Does anyone in this application need an intermediary to help them in court?
    Then I choose "No"
    And I click the "Continue" button
    Then I should see "Do you or the children need specific safety arrangements at court?"

    # Do you or the children need specific safety arrangements at court?
    Then I click the "Continue" button
    Then I should see "Does anyone in this application need assistance or special facilities when attending court?"

    # Does anyone in this application need assistance or special facilities when attending court?
    Then I click the "Continue" button
    Then I should see "How would you like to submit your application to court?"

    # How would you like to submit your application to court?
    Then I choose "Submit electronically"
    And I click the "Continue" button
    Then I should see "How will you pay the application fee?"

    # How will you pay the application fee?
    Then I choose "Pay with ‘Help with fees’"
    And I fill in "Reference number" with "HWF-111-111"
    And I click the "Continue" button
    Then I should see "Check your answers"

    # Check your answers
    Then I click the radio button "I believe that the facts stated in this form and any continuation sheet are true"
    And I fill in "Enter your full name" with "John Doe Senior"
    And I click the "Submit application" button

    # Your application has been submitted
    Then I should see "Your application has been submitted"
