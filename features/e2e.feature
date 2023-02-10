Feature: End to End test of C100
  What happens when I try to run C100 staging end to end

  Background:
    When I visit "https://c100-application-staging.apps.live.cloud-platform.service.justice.gov.uk"
    Then I should see "What you'll need to complete your application"
    And I should see a "Or return to a saved application" link to "https://c100-application-staging.apps.live.cloud-platform.service.justice.gov.uk/users/login"
    And I should see a "Back" link to "https://www.gov.uk/looking-after-children-divorce/apply-for-court-order"
    When I click the "Continue" link
    Then I should see "Where do the children live?"
    And I should see "If you do not know where the children live"
    And I should see a "Back" link to "https://c100-application-staging.apps.live.cloud-platform.service.justice.gov.uk"

  Scenario: Entering a postcode where the children live, selecting the Child arrangements order application type of application to make
    When I fill in "Postcode" with "EC3A 2AD"
    And I wait and click the "Continue" button
    Then I should see "What kind of application do you want to make?"
    When I choose "Child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order"
    Then I should see "Does this application concern a child who is the subject of separate ongoing emergency proceedings, care proceedings or supervision proceedings (or is already the subject of an emergency, care or supervision order)?"
    And I choose "No"
    Then I should see "Attending a Mediation Information and Assessment Meeting (MIAM)"

  Scenario: Continuing from MIAM page to find a mediator
    When I fill in "Postcode" with "EC3A 2AD"
    And I wait and click the "Continue" button
    Then I should see "What kind of application do you want to make?"
    When I choose "Child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order"
    Then I should see "Does this application concern a child who is the subject of separate ongoing emergency proceedings, care proceedings or supervision proceedings (or is already the subject of an emergency, care or supervision order)?"
    And I choose "No"
    Then I should see "Attending a Mediation Information and Assessment Meeting (MIAM)"
    And I should see the save draft button
    And I should see a "Back" link to "https://c100-application-staging.apps.live.cloud-platform.service.justice.gov.uk/steps/opening/child_protection_cases"
    And I should see "Have you previously been to mediation through the mediation voucher scheme?"
    And I choose "Yes"
    And I check "I understand that I have to attend a MIAM or provide a valid reason for not attending."
    And I click the "Continue" button
    Then I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "No"
    Then I should see "Has a mediator confirmed that you do not need to attend a MIAM?"
    And I choose "No"
    Then I should see "Do you have a valid reason for not attending a MIAM?"
    And I should see a "check the list of valid reasons" link to "https://c100-application-staging.apps.live.cloud-platform.service.justice.gov.uk/about/miam_exemptions"
    And I choose "No"
    Then I should see "You must attend a MIAM"
    And I fill in "Enter your postcode to find a mediator" with "EC3A 2AD"

  Scenario: Continuing from MIAM page to upload a signed document
    When I fill in "Postcode" with "EC3A 2AD"
    And I wait and click the "Continue" button
    Then I should see "What kind of application do you want to make?"
    When I choose "Child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order"
    Then I should see "Does this application concern a child who is the subject of separate ongoing emergency proceedings, care proceedings or supervision proceedings (or is already the subject of an emergency, care or supervision order)?"
    And I choose "No"
    Then I should see "Attending a Mediation Information and Assessment Meeting (MIAM)"
    And I should see the save draft button
    And I should see a "Back" link to "https://c100-application-staging.apps.live.cloud-platform.service.justice.gov.uk/steps/opening/child_protection_cases"
    And I should see "Have you previously been to mediation through the mediation voucher scheme?"
    And I choose "Yes"
    And I check "I understand that I have to attend a MIAM or provide a valid reason for not attending."
    And I click the "Continue" button
    Then I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I should see a "Back" link to "https://c100-application-staging.apps.live.cloud-platform.service.justice.gov.uk/steps/miam/acknowledgement"
    And I should see the save draft button
    And I choose "Yes"
    Then I should see "Have you got a document signed by the mediator?"
    And I should see a "Back" link to "https://c100-application-staging.apps.live.cloud-platform.service.justice.gov.uk/steps/miam/attended"
    And I should see the save draft button
    And I choose "Yes"
    Then I should see "Upload your MIAM certificate"
    And I should see a "Back" link to "https://c100-application-staging.apps.live.cloud-platform.service.justice.gov.uk/steps/miam/certification"
    And I should see the save draft button

  Scenario: Continuing from Safety concerns page to end
    Given I am on safety concern page
    And I click the "Continue" button
    Then I should see "Are the children at risk of being abducted"
    And I choose "No" 
    Then I should see "Do you have any concerns about drug, alcohol or substance abuse?"
    And I choose "No"
    Then I should see "Have the children suffered or are they at risk of suffering domestic or child abuse?"
    And I should see a "Find out about the signs of child abuse" link to "https://www.nspcc.org.uk/what-is-child-abuse/types-of-abuse/"
    And I choose "No"
    Then I should see "Have you suffered or are you at risk of suffering domestic violence or abuse?"
    And I choose "No"
    Then I should see "Do you have any other safety concerns about you or the children?"
    And I choose "No"
    Then I should see "What are you asking the court to decide about the children involved?"
    And I choose "Decide who they live with and when"
    Then I should see "What you’re asking the court to decide about the children"
    And I click the "Continue" button
    Then I should see "Going to court"
    And I should see a "Find out more about going to court" link to "https://helpwithchildarrangements.service.justice.gov.uk/going-to-court"
    And I should see a "how to represent yourself in court" link to "https://www.gov.uk/represent-yourself-in-court"
    And I should see a "legal aid and domestic violence or abuse." link to "https://www.gov.uk/legal-aid/domestic-abuse-or-violence"
    And I should see a "domestic violence or abuse" link to "https://refuge.org.uk/get-help-now/help-for-women/recognising-abuse/"
    And I should see a "child abuse" link to "https://www.nspcc.org.uk/what-is-child-abuse/types-of-abuse/"
    And I check "I understand what’s involved if I decide to go to court"
    And I click the "Continue" button
    Then I should see "Alternative ways to reach an agreement"
    And I click the "Continue" button
    Then I should see "Negotiation tools and services"
    And I choose "Yes"
    Then I should see "Professional mediation"
    And I choose "Yes"
    Then I should see "Lawyer negotiation"
    And I choose "Yes"
    Then I should see "Collaborative law"
    And I choose "Yes"
    Then I should see "Enter the names of the children"
    And I have entered a child with first name "Test" and last name "Child"
    And I click the "Continue" button
    Then I should see "Provide details for Test Child"
    And I fill in "Day" with "1"
    And I fill in "Month" with "1"
    And I fill in "Year" with "2022"
    And I choose "Unspecified"
    Then I should see "Which of the decisions you’re asking the court to resolve relate to Test Child?"
    And I choose "Decide who they live with and when"
    Then I should see "Is there a Special Guardianship Order in force in relation to Test Child?"
    And I choose "No"
    Then I should see "Parental responsibility for Test Child"
    And I should see a "See section E of leaflet CB1 for more information" link to "https://www.gov.uk/government/publications/family-court-applications-that-involve-children-cb1"
    And I fill in "steps_children_parental_responsibility_form[parental_responsibility]" with "Test Text"
    And I click the "Continue" button
    Then I should see "Further information"
    And I should see "Are any of the children known to social services?"
    And I should see "Are any of the children the subject of a child protection plan?"
    And I check "Don't Know"
    And I check "Don't Know"
    And I click the "Continue" button
    Then I should see "Do you or any respondents have other children who are not part of this application?"
    And I choose "No"
    Then I should see "Enter your name"
    And I fill in "First name(s)" with "Test"
    And I fill in "Last name(s)" with "Human"
    And I click the "Continue" button 
    Then I should see "Keeping your contact details private"
    And I choose "I don't know"
    Then I should see "Keeping your contact details private"
    And I choose "No"
    Then I should see "The court will not keep your contact details private"
    And I click the "Continue" button
    Then I should see "Provide details for Test Human"
    And I check "No"
    And I check "Unspecified"
    And I fill in "Day" with "1"
    And I fill in "Month" with "1"
    And I fill in "Year" with "1990"
    And I fill in "Your place of birth" with "Some place"
    And I click the "Continue" button
    Then I should see "What is Test Human's relationship to Test Child?"
    And I choose "Mother"
    Then I should see "Address of Test Human"
    And I fill in "Current postcode" with "EC3A 2AA"
    And I click the "Continue" button
    Then I should see "Select address of Test Human"
    And I click the "Continue" button
    Then I should see "Address details of Test Human"
    And I fill in "Building and street" with "Some Building Some Street"
    And I fill in "Town or city" with "Some town"
    And I choose "Yes"
    Then I should see "Contact details of Test Human"
    And I check "I cannot provide an email address"
    And I fill in "Your home phone" with "00000000"
    And I check "I can provide a mobile phone number"
    And I fill in "Your mobile phone" with "00000000"
    And I choose "Yes, the court can leave me a voicemail"
    Then I should see "Will you be legally represented by a solicitor in these proceedings?"
    And I choose "Yes"
    Then I should see "Details of solicitor"
    And I fill in "Full name" with "Test name"
    And I fill in "Name of firm" with "Test firm"
    And I fill in "Solicitor’s reference" with "Test reference"
    Then I should see "Address details of Test name"
    And I fill in "Building and street" with "Some Building Some Street"
    And I fill in "Town or city" with "Some town"
    And I fill in "Country" with "United Kingdom"
    And I fill in "Postcode" with "EC3A 2AB"
    And I click the "Continue" button
    Then I should see "Contact details of Test name"
    And I fill in "Email address" with "test@email.com"
    And I fill in "Phone number" with "00000000"
    And I click the "Continue" button
    Then I should see "Enter the respondent’s name"
    And I fill in "First name(s)" with "Test"
    And I fill in "Last name(s)" with "Respondent"
    And I click the "Continue" button
    Then I should see "Provide details for Test Respondent"
    And I check "No"
    And I check "Unspecified"
    And I fill in "Day" with "1"
    And I fill in "Month" with "1"
    And I fill in "Year" with "1990"
    And I check "I don’t know their place of birth"
    And I click the "Continue" button
    Then I should see "What is Test Respondent's relationship to Test Child?"
    And I choose "Father"
    Then I should see "Address of Test Respondent"
    And I fill in "Current postcode" with "EC3A 2AE"
    And I click the "Continue" button
    Then I should see "Select address of Test Respondent"
    And I click the "Continue" button
    Then I should see "Address details of Test Respondent"
    And I fill in "Building and street" with "Some Place Some Street"
    And I fill in "Town or city" with "Some other town"
    And I check "Yes"
    And I click the "Continue" button
    Then I should see "Address details of Test Respondent"
    And I fill in "Building and street" with "Some Building Test Street"
    And I fill in "Town or city" with "Some test town"
    And I check "Yes"
    And I click the "Continue" button
    Then I should see "Contact details of Test Respondent"
    And I check "I don't know their email"
    And I check "I don't know their home phone number"
    And I check "I don't know their mobile number"
    And I click the "Continue" button
    Then I should see "Is there anyone else who should know about your application?"
    And I choose "No"
    Then I should see "Who does Test Child currently live with?"
    And I choose "Test Human"
    Then I should see "Have any of the children in this application been involved in other family court proceedings?"
    And I choose "No"
    Then I should see "Do you need an urgent hearing?"
    And I choose "No"
    Then I should see "Are you asking for a without notice hearing?"
    And I choose "No"
    Then I should see "Is the life of the child or children, a parent, or anyone significant to the children mainly based in a country outside England or Wales?"
    And I choose "No"
    Then I should see "Do you think another person in this application may be able to apply for a similar order in a country outside England or Wales?"
    And I choose "No"
    Then I should see "Has a request for information or other assistance involving the children been made to or by another country?"
    And I choose "No"
    Then I should see "Why are you making this application?"
    And I fill in "Provide details" with "test text"
    Then I should see "Are there any factors that may affect any adult in this application taking part in the court proceedings?"
    And I choose "No"
    Then I should see "Does anyone in this application need an intermediary to help them in court?"
    And I choose "No"
    Then I should see "Does anyone in this application have special language requirements?"
    And I click the "Continue" button
    Then I should see "Do you or the children need specific safety arrangements at court?"
    And I click the "Continue" button
    Then I should see "Does anyone in this application need assistance or special facilities when attending court?"
    And I click the "Continue" button
    Then I should see "How would you like to submit your application to court?"
    And I choose "Submit electronically"
    Then I should see "How will you pay the application fee?"
    And I choose "Pay online"
    Then I should see "Check your answers"
    
    