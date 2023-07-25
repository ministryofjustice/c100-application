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
    And I fill in "Email address" with "Jane@Hotmail.com"
    And I check "I don't know their home phone number"
    And I fill in "Mobile phone" with "00000000000"
    And I click the "Continue" button
    Then I should see "Is there anyone else who should know about your application?"
    And I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Who does Jane Doe Jnr currently live with?"
    And I check "John Doe"
    And I click the "Continue" button
    Then I should see "Have any of the children in this application been involved in other family court proceedings?"
    And I click the radio button "Yes"
    And I click the "Continue" button
    Then I should see "Details of previous court case"
    And I fill in "Names of children involved" with "Jane Doe Jnr"
    And I fill in "Name of court" with "London Court"
    And I fill in "Date/year" with "2020"
    And I fill in "Type of proceedings" with "Legal hearing"
    And I fill in "Add details of any other previous family case" with "Lasted for weeks"
    And I click the "Continue" button
    Then I should see "Do you need an urgent hearing?"
    And I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Are you asking for a without notice hearing?"
    And I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Is the life of the child or children, a parent, or anyone significant to the children mainly based in a country outside England or Wales?"
    And I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Do you think another person in this application may be able to apply for a similar order in a country outside England or Wales?"
    And I click the radio button "Yes"
    And I fill in "Provide details" with "Details"
    And I click the "Continue" button
    Then I should see "Has a request for information or other assistance involving the children been made to or by another country?"
    And I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Why are you making this application?"
    And I fill in "Provide details" with "I fear for the safety of Jane Doe Jnr and I want her to be safe"
    And I click the "Continue" button
    Then I should see "Are there any factors that may affect any adult in this application taking part in the court proceedings?"
    And I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Does anyone in this application need an intermediary to help them in court?"
    And I click the radio button "No"
    And I click the "Continue" button
    Then I should see "Does anyone in this application have special language requirements?"
    And I click the "Continue" button
    Then I should see "Do you or the children need specific safety arrangements at court?"
    And I click the "Continue" button
    Then I should see "Does anyone in this application need assistance or special facilities when attending court?"
    And I fill in "You can add more detail if necessary" with "We need lots of light"
    And I click the "Continue" button
    Then I should see "Submitting your application to court"
    And I fill in "Enter an email address if you would like to get a confirmation" with "John@Gmail.com"
    And I click the "Continue" button
    Then I should see "Is this email address correct?"
    And I should see "john@gmail.com"
    And I click the "Yes, continue" link
    Then I should see "How will you pay the application fee?"
    And I click the radio button "Pay with ‘Help with fees’"
    And I fill in "Reference number" with "HWF-123-456"
    And I click the "Continue" button
    Then I should see "Check your answers"
    And I should see "Do you have a solicitor? Yes"
    And I should see "Full name Jane Doe"
    And I should see they have made an application related to a child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order
    And I should see the children "aren't" involved in any emergency protection, care of proceedings
    And I should see they "haven't" been to mediation through the mediation voucher scheme
    And I should see they have attended MIAM
    And I should see they have a document signed by the mediator
    And I should see they "haven't" got safety concerns about the children
    And I should see they want the court to decide: "Decide who they live with and when"
    And I should see the child's full name is "Jane Doe Jnr"
    And I should see the child's date of birth is "01-01-2023"
    And I should see the child's gender is "Female"
    And I should see the applicant's name is "John Doe"
    And I should see the applicant's gender is "Male"
    And I should see the applicant's date of birth is "01-01-1990"
    And I should see the applicant's place of birth is "London"
    And I should see the applicant's address is "Buckingham Palace, London, United Kingdom, SW1A 1AA"
    And I should see the applicant has provided an email "john@gmail.com"
    And I should see the applicant has provided a home telephone number "00000000000"
    And I should see the applicant has provided a mobile number "00000000000"
    And I should see the applicant "does" have a solicitor
    And I should see the solicitor's reference is "123456"
    And I should see the solicitor's full name is "Annalise Keating"
    And I should see the solicitor's address is "Windsor Castle, Windsor, United Kingdom, SL4 1QF"
    And I should see the solicitor's email is "annalise@law.com" and phone number is "00000000000"
    And I should see the respondent's name is "Jane Doe"
    And I should see the respondent's date of birth is "01-01-1991"
    And I should see the respondent's gender is "Female"
    And I should see the respondent's place of birth is "London"
    And I should see the respondent's address is "Windsor Castle, Windsor, United Kingdom, SL4 1QF"
    And I should see the respondent "has" lived at that address for more than 5 years
    And I should see the respondent's email is "jane@hotmail.com"
    And I should see the respondent's mobile phone number is "00000000000"
    And I should see the respondent's relationship to "Jane Doe Jnr" is "Mother"
    And I should see there "aren't" other people who need to be informed of the application
    And I should see the child "Jane Doe Jnr" lives with "John Doe"
    And I should see the children "have" been involved in other proceedings
    And I should see the names of the children involved in other proceedings are "Jane Doe Jnr"
    And I should see the name of the court is "London Court"
    And I should see the date of the proceeding is "2020"
    And I should see the type of proceeding is "Legal hearing"
    And I should see an urgent hearing "isn't" requested
    And I should see a without notice hearing "isn't" requested
    And I should see the life of someone significant to the child "isn't" outside the UK
    And I should see another person in this application "could" apply for an order outside the UK
    And I should see a request for information involving the children "hasn't" been made outside the UK
    And I should see the reason for application is "I fear for the safety of Jane Doe Jnr and I want her to be safe"
    And I should see there "aren't" factors that may affect any adult in this application taking part in the court proceedings
    And I should see there "aren't" people who need an intermediary to help them in court
    And I should see there "aren't" special language requirements
    And I should see there "aren't" specific safety arrangements specified for the court
    And I should see there "are" special facilities needed when attending court
    And I should see the email for submitting an application to court is "john@gmail.com"
    And I should see the payment type "Help with fees"
    And I should see the HwF reference number is "HWF-123-456"

  Scenario: Child arrangements order (MIAM) (path two: 'No' to 'Have you attended a MIAM?')
    When I choose "Child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order"
    Then I should see "Does this application concern a child who is the subject of separate ongoing emergency proceedings, care proceedings or supervision proceedings (or is already the subject of an emergency, care or supervision order)?"
    And I choose "Yes"
    Then I should see "You do not have to attend a MIAM"
    And I click the "Continue" link
    Then I should see "Safety concerns"
    When I click the "Back" link
    And I click the "Back" link
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
    And I choose "No"
    Then I should see "You need to get a document from the mediator"
    And I click the "Back" link
    And I choose "Yes"
    Then I should see "Upload your MIAM certificate"
    When I upload a document to the MIAM certificate page
    And I click the "Continue" button
    Then I should see "Safety concerns"
    And I click the "Continue" link
    Then I should see "Are the children at risk of being abducted?"
    And I choose "Yes"
    Then I should see "Have the police been notified?"
    And I choose "Yes"
    Then I should see "Do any of the children have a passport?"
    And I choose "Yes"
    Then I should see "Provide details of the children’s passports"
    And I check "Other"
    And I fill in "Provide more details" with "Grandparents"
    And I choose "No"
    Then I should see "Have the children been abducted or kept outside the UK without your consent before?"
    And I choose "Yes"
    And I should see "Provide details of the previous abductions"
    Then I click the "Back" link
    And I choose "No"
    Then I should see "Why do you think the children may be abducted or kept outside the UK without your consent?"
    And I fill in "Briefly explain your concerns about abduction" with "They might be taken by mean people"
    And I fill in "Where are the children now?" with "They are safe and sound"
    And I click the "Continue" button
    Then I should see "Do you have any concerns about drug, alcohol or substance abuse?"
    And I click the radio button "Yes"
    And I fill in "Give a short description of the drug, alcohol or substance abuse" with "Alcoholic and drug abuse details"
    And I click the "Continue" button
    Then I should see "You and the children"
    And I click the "Continue" link
    Then I should see "The children’s safety"
    And I click the "Continue" link
    Then I should see "Have the children ever been sexually abused by the respondent?"
    And I choose "No"
    Then I should see "Have the children ever been physically abused by the respondent?"
    And I choose "No"
    Then I should see "Have the children ever been financially abused by the respondent?"
    And I choose "Yes"
    Then I should see "About the children’s financial abuse"
    And I fill in "Briefly describe what happened and who was involved, if you feel able to" with "They held money problems over the kids"
    And I fill in "When did this behaviour start?" with "Many years ago"
    And I choose "No" for all options on this page
    And I fill in "When did the behaviour stop?" with "About two years ago"
    And I click the "Continue" button
    Then I should see "Have the children ever been psychologically abused by the respondent?"
    And I choose "Yes"
    Then I should see "About the children’s psychological abuse"
    And I fill in "Briefly describe what happened and who was involved, if you feel able to" with "The respondent guilt tripped the kids"
    And I fill in "When did this behaviour start?" with "Many years ago"
    And I choose "No" for all options on this page
    And I fill in "When did the behaviour stop?" with "About two years ago"
    And I click the "Continue" button
    Then I should see "Have the children ever been emotionally abused by the respondent?"
    And I choose "Yes"
    Then I should see "About the children’s emotional abuse"
    And I fill in "Briefly describe what happened and who was involved, if you feel able to" with "The respondent was mean to the kids"
    And I fill in "When did this behaviour start?" with "Many years ago"
    And I choose "No" for all options on this page
    And I fill in "When did the behaviour stop?" with "About two years ago"
    And I click the "Continue" button
    Then I should see "Do you have any other safety or welfare concerns about the children?"
    And I choose "Yes"
    Then I should see "Other concerns about the children"
    And I fill in "Briefly describe what happened and who was involved, if you feel able to" with "The respondent might be mean to the kids again"
    And I fill in "When did this behaviour start?" with "Many years ago"
    And I choose "No" for all options on this page
    And I fill in "When did the behaviour stop?" with "About two years ago"
    And I click the "Continue" button
    Then I should see "Your safety"
    And I click the "Continue" link
    Then I should see "Have you ever been sexually abused by the respondent?"
    And I choose "No"
    Then I should see "Have you ever been physically abused by the respondent?"
    And I choose "Yes"
    Then I should see "About the physical abuse"
    And I fill in "Briefly describe what happened and who was involved, if you feel able to" with "The respondent hit me"
    And I fill in "When did this behaviour start?" with "Many years ago"
    And I choose "No" for all options on this page
    And I fill in "When did the behaviour stop?" with "About two years ago"
    And I click the "Continue" button
    Then I should see "Have you ever been financially abused by the respondent?"
    And I choose "Yes"
    Then I should see "About the financial abuse"
    And I fill in "Briefly describe what happened and who was involved, if you feel able to" with "The respondent took my money"
    And I fill in "When did this behaviour start?" with "Many years ago"
    And I choose "No" for all options on this page
    And I fill in "When did the behaviour stop?" with "About two years ago"
    And I click the "Continue" button
    Then I should see "Have you ever been psychologically abused by the respondent?"
    And I choose "No"
    Then I should see "Have you ever been emotionally abused by the respondent?"
    And I choose "No"
    Then I should see "Do you have any other concerns about your welfare?"
    And I choose "No"
    Then I should see "Have you had or do you currently have any court orders made for your protection?"
    And I choose "Yes"
    And I choose "No" for all options on this page
    Then I should see "Contact between the children and the other people in this application"
    And I choose "No" for all options on this page
    And I click the "Continue" button
    Then I should see "What are you asking the court to decide about the children involved?"
    And I check "Decide who they live with and when"
    And I check "Decide how much time they spend with each person"
    And I click the "Continue" button
    Then I should see "What you’re asking the court to decide about the children"
    And I should see "Decide who they live with and when"
    And I should see "Decide how much time they spend with each person"
    And I click the "Continue" link
    Then I should see "Is there anything else you are asking the court to decide, specifically to protect the safety of you or the children?"
    And I click the radio button "Yes"
    And I fill in "Please give details" with "I want the court to decide whether the respondent should give compensation"
    And I click the "Continue" button
    Then I should see "Going to court"
    And I should see "What happens at court"
    And I should see "Changing or enforcing an order"
    And I should see "Representing yourself in court"
    And I should see "Domestic violence or abuse and child abuse"
    And I check "I understand what’s involved if I decide to go to court"
    And I click the "Continue" button
    Then I should see "Enter the names of the children"
    And I fill in "First name(s)" with "Emily"
    And I fill in "Last name(s)" with "Doe"
    And I click the "Continue" button
    Then I should see "Provide details for Emily Doe"
    And I enter the date 1-1-2020
    And I click the radio button "Female"
    And I click the "Continue" button
    Then I should see "Which of the decisions you’re asking the court to resolve relate to Emily Doe?"
    And I check "Decide who they live with and when"
    And I check "Decide how much time they spend with each person"
    And I click the "Continue" button
    Then I should see "Is there a Special Guardianship Order in force in relation to Emily Doe?"
    And I choose "No"
    Then I should see "Parental responsibility for Emily Doe"
    And I fill in "State everyone who has parental responsibility for Emily Doe and how they have parental responsibility." with "Mother"
    And I click the "Continue" button
    And I choose "Don't know" for all options on this page
    Then I should see "Do you or any respondents have other children who are not part of this application?"
    And I choose "Yes"
    Then I should see "Enter the other child’s name"
    And I fill in "First name(s)" with "John"
    And I fill in "Last name(s)" with "Doe"
    And I click the "Continue" button
    Then I should see "Provide details for John Doe"
    And I enter the date 10-10-2020
    And I choose "Male"
    Then I should see "Enter your name"
    And I fill in "First name(s)" with "Jane"
    And I fill in "Last name(s)" with "Doe"
    And I click the "Continue" button
    Then I should see "Keeping your contact details private"
    And I choose "I don't know"
    Then I should see "Keeping your contact details private"
    And I click the radio button "Yes"
    And I check "Current address"
    And I click the "Continue" button
    Then I should see "The court will keep your contact details private"
    And I should see "You have told us you want to keep these contact details private"
    And I should see "Current address"
    And I click the "Continue" link
    Then I should see "Provide details for Jane Doe"
    And I click the radio button "Yes"
    And I fill in "Enter your previous name" with "Olivia Doe Jr"
    And I click the radio button "Female"
    And I enter the date 10-10-1990
    And I fill in "Your place of birth" with "London"
    And I click the "Continue" button
    Then I should see "What is Jane Doe's relationship to Emily Doe?"
    And I choose "Mother"
    Then I should see "What is Jane Doe's relationship to John Doe?"
    And I choose "Mother"
    Then I should see "Address of Jane Doe"
    And I click the "I live outside the UK" link
    Then I should see "Address details of Jane Doe"
    And I fill in "Building and street" with "Windsor Castle"
    And I fill in "Town or city" with "Windsor"
    And I fill in "Country" with "United Kingdom"
    And I fill in "Postcode" with "SL4 1QF"
    And I click the radio button "Yes"
    And I click the "Continue" button
    Then I should see "Contact details of Jane Doe"
    And I click the radio button "I can provide an email address"
    And I fill in "Your email address" with "jane_doe@gmail.com"
    And I fill in "Your home phone" with "00000001111"
    And I click the radio button "I can provide a mobile phone number"
    And I fill in "Your mobile phone" with "00000888888"
    And I choose "Yes, the court can leave me a voicemail"
    Then I should see "Will you be legally represented by a solicitor in these proceedings?"
    And I choose "No"
    Then I should see "Enter the respondent’s name"
    And I fill in "First name(s)" with "John"
    And I fill in "Last name(s)" with "Doe"
    And I click the "Continue" button
    Then I should see "Provide details for John Doe"
    And I click the radio button "No"
    And I click the radio button "Male"
    And I enter the date 12-12-1970
    And I fill in "Place of birth" with "Windsor"
    And I click the "Continue" button
    Then I should see "What is John Doe's relationship to Emily Doe?"
    And I choose "Father"
    Then I should see "What is John Doe's relationship to John Doe?"
    And I choose "Father"
    Then I should see "Address of John Doe"
    And I click the "I don’t know their postcode or they live outside the UK" link
    And I should see "Address details of John Doe"
    And I fill in "Building and street" with "Windsor Castle"
    And I fill in "Town or city" with "Windsor"
    And I fill in "Country" with "United Kingdom"
    And I fill in "Postcode" with "SL4 1QF"
    And I click the radio button "Don't know"
    And I fill in "Please provide details of all previous addresses for the last 5 years below, including the dates and starting with the most recent" with "They may have lived in Buckingham Palace"
    And I click the "Continue" button
    Then I should see "Contact details of John Doe"
    And I fill in "Email address" with "john-doe@hotmail.com"
    And I fill in "Mobile phone" with "00000999999"
    And I choose "I don't know their home phone number"
    And I click the "Continue" button
    Then I should see "Is there anyone else who should know about your application?"
    And I choose "Yes"
    Then I should see "Enter the other person’s name"
    And I fill in "First name(s)" with "Judy"
    And I fill in "Last name(s)" with "Sitter"
    And I click the "Continue" button
    Then I should see "Provide details for Judy Sitter"
    And I click the radio button "No"
    And I click the radio button "Female"
    And I enter the date 10-1-1991
    And I click the "Continue" button
    Then I should see "What is Judy Sitter's relationship to Emily Doe?"
    And I click the radio button "Other"
    And I fill in "Please specify" with "Caregiver"
    And I click the "Continue" button
    Then I should see "What is Judy Sitter's relationship to John Doe?"
    And I click the radio button "Other"
    And I fill in "Please specify" with "Caregiver"
    And I click the "Continue" button
    Then I should see "Address of Judy Sitter"
    And I click the "I don’t know their postcode or they live outside the UK" link
    And I fill in "Building and street" with "10 Downing Street"
    And I fill in "Town or city" with "London"
    And I fill in "Country" with "United Kingdom"
    And I fill in "Postcode" with "SW1A 1AA"
    And I click the "Continue" button
    Then I should see "Who does Emily Doe currently live with?"
    And I should see "Jane Doe"
    And I should see "John Doe"
    And I should see "Judy Sitter"
    And I check "Jane Doe"
    And I click the "Continue" button
    Then I should see "Have any of the children in this application been involved in other family court proceedings?"
    And I choose "Yes"
    And I fill in "Names of children involved" with "Emily Doe and John Doe"
    And I fill in "Name of court" with "Aylesbury"
    And I fill in "Date/year" with "March 2020"
    And I fill in "Type of proceedings" with "Care order"
    And I fill in "Add details of any other previous family case" with "Emily Doe was involved in a care order which took place at Aylesbury court"
    And I click the "Continue" button
    Then I should see "Do you need an urgent hearing?"
    And I choose "No"
    Then I should see "Are you asking for a without notice hearing?"
    And I choose "No"
    Then I should see "Is the life of the child or children, a parent, or anyone significant to the children mainly based in a country outside England or Wales?"
    And I click the radio button "Yes"
    And I fill in "Provide details" with "Emily's maternal grandparents are in Austria"
    And I click the "Continue" button
    Then I should see "Do you think another person in this application may be able to apply for a similar order in a country outside England or Wales?"
    And I choose "No"
    Then I should see "Has a request for information or other assistance involving the children been made to or by another country?"
    And I choose "No"
    Then I should see "Why are you making this application?"
    And I fill in "Provide details" with "I fear for Emily & John's safety, but particularly Emily's"
    And I click the "Continue" button
    Then I should see "Are there any factors that may affect any adult in this application taking part in the court proceedings?"
    And I choose "Yes"
    Then I should see "Factors affecting ability to participate"
    And I click the "Continue" button
    Then I should see "Does anyone in this application need an intermediary to help them in court?"
    And I choose "Yes"
    Then I fill in "Provide details" with "Needed for the respondent"
    And I click the "Continue" button
    Then I should see "Does anyone in this application have special language requirements?"
    And I check "An interpreter"
    And I fill in "Give details of who needs an interpreter and the language they require (including dialect, if applicable)" with "German needed for respondent"
    And I click the "Continue" button
    Then I should see "Do you or the children need specific safety arrangements at court?"
    And I fill in "You can add more detail if necessary" with "Please keep the time the kids are needed for to a minimum"
    And I click the "Continue" button
    Then I should see "Does anyone in this application need assistance or special facilities when attending court?"
    And I click the "Continue" button
    Then I should see "Submitting your application to court"
    And I fill in "Enter an email address if you would like to get a confirmation" with "jane_doe@gmail.com"
    And I click the "Continue" button
    Then I should see "Is this email address correct?"
    And I should see "jane_doe@gmail.com"
    And I click the "Yes, continue" link
    Then I should see "How will you pay the application fee?"
    And I choose "Pay with ‘Help with fees’"
    And I fill in "Reference number" with "HWF-123-456"
    And I click the "Continue" button
    Then I should see "Check your answers"
    And I should see "Child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order"
    And I should see they have made an application related to a child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order
    And I should see the children "aren't" involved in any emergency protection, care of proceedings
    And I should see they "haven't" been to mediation through the mediation voucher scheme
    And I should see they haven't attended MIAM
    And I should see they are exempt from an MIAM
    And I should see they have a document signed by the mediator
    And I should see they "have" got safety concerns about the children
    And I should see they have safety concerns with the children about: "financial abuse, psychological abuse, emotional abuse, other abuse"
    And I should see they have safety concerns with themselves about: "physical abuse, financial abuse"
    And I should see "No, I do not want the other person to spend time with the children"
    And I should see they want the court to decide: "Decide who they live with and when"
    And I should see they want the court to decide: "Decide how much time they spend with each person"
    And I should see the child's full name is "Emily Doe"
    And I should see the child's gender is "Female"
    And I should see the child's date of birth is "01-01-2020"
    And I should see the applicant's name is "Jane Doe"
    And I should see the applicant's previous name is "Olivia Doe Jr"
    And I should see the applicant's gender is "Female"
    And I should see the applicant's date of birth is "10-10-1990"
    And I should see the applicant's place of birth is "London"
    And I should see the applicant's address is "Windsor Castle, Windsor, United Kingdom, SL4 1QF"
    And I should see the applicant has provided an email "jane_doe@gmail.com"
    And I should see the applicant has provided a home telephone number "00000001111"
    And I should see the applicant has provided a mobile number "00000888888"
    And I should see the applicant "doesn't" have a solicitor
    And I should see the respondent's name is "John Doe"
    And I should see the respondent's gender is "Male"
    And I should see the respondent's date of birth is "12-12-1970"
    And I should see the respondent's place of birth is "Windsor"
    And I should see the respondent's address is "Windsor Castle, Windsor, United Kingdom, SL4 1QF"
    And I should see the respondent "might not have" lived at that address for more than 5 years
    And I should see the respondent's email is "john-doe@hotmail.com"
    And I should see the respondent's mobile phone number is "00000999999"
    And I should see the respondent's relationship to "Emily Doe" is "Father"
    And I should see the respondent's relationship to "John Doe" is "Father"
    And I should see there "are" other people who need to be informed of the application
    And I should see the other party's name is "Judy Sitter"
    And I should see the other party's gender is "Female"
    And I should see the other party's date of birth is "10-01-1991"
    And I should see the other party's address is "10 Downing Street, London, United Kingdom, SW1A 1AA"
    And I should see the other party's relationship to "John Doe" is "Caregiver"
    And I should see the other party's relationship to "Emily Doe" is "Caregiver"
    And I should see the child "Emily Doe" lives with "Jane Doe"
    And I should see the children "have" been involved in other proceedings
    And I should see the names of the children involved in other proceedings are "Emily Doe and John Doe"
    And I should see the name of the court is "Aylesbury"
    And I should see the date of the proceeding is "March 2020"
    And I should see the type of proceeding is "Care order"
    And I should see an urgent hearing "isn't" requested
    And I should see a without notice hearing "isn't" requested
    And I should see the life of someone significant to the child "is" outside the UK
    And I should see another person in this application "couldn't" apply for an order outside the UK
    And I should see a request for information involving the children "hasn't" been made outside the UK
    And I should see the reason for application is "I fear for Emily & John's safety, but particularly Emily's"
    And I should see there "are" factors that may affect any adult in this application taking part in the court proceedings
    And I should see there "are" people who need an intermediary to help them in court
    And I should see the details provided for the intermediary are "Needed for the respondent"
    And I should see there "are" special language requirements
    And I should see there "are" specific safety arrangements specified for the court
    And I should see there "aren't" special facilities needed when attending court
    And I should see the email for submitting an application to court is "jane_doe@gmail.com"
    And I should see the payment type "Help with fees"
    And I should see the HwF reference number is "HWF-123-456"
    And I should see the statement of truth

  Scenario: Consent order
    When I click the radio button "Consent order"
    And I click the "Continue" button
    And I should see "Upload the draft of your consent order"
    Then I upload a document to the consent order page
    And I click the "Continue" button
    Then I should see "You do not have to attend a MIAM"
    And I click the "Continue" link
    Then I should see "Does this application concern a child who is the subject of separate ongoing emergency proceedings, care proceedings or supervision proceedings (or is already the subject of an emergency, care or supervision order)?"
    And I choose "Yes"
    Then I should see "Safety concerns"
    And I should see "Why do we need this information and what will we do with it?"
    And I click the "Continue" link
    Then I should see "Are the children at risk of being abducted?"
    And I choose "No"
    Then I should see "Do you have any concerns about drug, alcohol or substance abuse?"
    And I choose "No"
    Then I should see "Have the children suffered or are they at risk of suffering domestic or child abuse?"
    And I choose "Yes"
    Then I should see "You and the children"
    And I click the "Continue" link
    Then I should see "The children’s safety"
    And I click the "Continue" link
    Then I should see "Have the children ever been sexually abused by the respondent?"
    And I choose "No"
    Then I should see "Have the children ever been physically abused by the respondent?"
    And I choose "No"
    Then I should see "Have the children ever been financially abused by the respondent?"
    And I choose "Yes"
    Then I should see "About the children’s financial abuse"
    And I fill in "Briefly describe what happened and who was involved, if you feel able to" with "The respondent took money from the kids"
    And I fill in "When did this behaviour start?" with "01-2023"
    And I choose "No" for all options on this page
    And I fill in "When did the behaviour stop?" with "06-2023"
    And I click the "Continue" button
    Then I should see "Have the children ever been psychologically abused by the respondent?"
    And I choose "Yes"
    Then I should see "About the children’s psychological abuse"
    And I fill in "Briefly describe what happened and who was involved, if you feel able to" with "The respondent was horrid to the kids"
    And I fill in "When did this behaviour start?" with "01-2023"
    And I choose "No" for all options on this page
    And I fill in "When did the behaviour stop?" with "06-2023"
    And I click the "Continue" button
    Then I should see "Have the children ever been emotionally abused by the respondent?"
    And I choose "Yes"
    Then I should see "About the children’s emotional abuse"
    And I fill in "Briefly describe what happened and who was involved, if you feel able to" with "The respondent made the kids sad on purpose"
    And I fill in "When did this behaviour start?" with "01-2023"
    And I choose "No" for all options on this page
    And I fill in "When did the behaviour stop?" with "06-2023"
    And I click the "Continue" button
    Then I should see "Do you have any other safety or welfare concerns about the children?"
    And I choose "No"
    Then I should see "Your safety"
    And I click the "Continue" link
    Then I should see "Have you ever been sexually abused by the respondent?"
    And I choose "Yes"
    Then I should see "About the sexual abuse"
    And I fill in "Briefly describe what happened and who was involved, if you feel able to" with "The respondent touched me non consensually"
    And I fill in "When did this behaviour start?" with "01-2023"
    And I choose "No" for all options on this page
    And I fill in "When did the behaviour stop?" with "06-2023"
    And I click the "Continue" button
    Then I should see "Have you ever been physically abused by the respondent?"
    And I choose "Yes"
    Then I should see "About the physical abuse"
    And I fill in "Briefly describe what happened and who was involved, if you feel able to" with "The respondent hit me several times"
    And I fill in "When did this behaviour start?" with "01-2023"
    And I choose "No" for all options on this page
    And I fill in "When did the behaviour stop?" with "06-2023"
    And I click the "Continue" button
    Then I should see "Have you ever been financially abused by the respondent?"
    And I choose "Yes"
    Then I should see "About the financial abuse"
    And I fill in "Briefly describe what happened and who was involved, if you feel able to" with "The respondent took money from me"
    And I fill in "When did this behaviour start?" with "01-2023"
    And I choose "No" for all options on this page
    And I fill in "When did the behaviour stop?" with "06-2023"
    And I click the "Continue" button
    Then I should see "Have you ever been psychologically abused by the respondent?"
    And I choose "Yes"
    Then I should see "About the psychological abuse"
    And I fill in "Briefly describe what happened and who was involved, if you feel able to" with "The respondent said awful things to me"
    And I fill in "When did this behaviour start?" with "01-2023"
    And I choose "No" for all options on this page
    And I fill in "When did the behaviour stop?" with "06-2023"
    And I click the "Continue" button
    Then I should see "Have you ever been emotionally abused by the respondent?"
    And I choose "Yes"
    Then I should see "About the emotional abuse"
    And I fill in "Briefly describe what happened and who was involved, if you feel able to" with "The respondent called me awful names"
    And I fill in "When did this behaviour start?" with "01-2023"
    And I choose "No" for all options on this page
    And I fill in "When did the behaviour stop?" with "06-2023"
    And I click the "Continue" button
    Then I should see "Do you have any other concerns about your welfare?"
    And I choose "No"
    Then I should see "Have you had or do you currently have any court orders made for your protection?"
    And I choose "No"
    Then I should see "Contact between the children and the other people in this application"
    And I choose "No" for all options on this page
    And I click the "Continue" button
    Then I should see "What are you asking the court to decide about the children involved?"
    And I check "Decide who they live with and when"
    And I check "Resolve a specific issue"
    And I check "A religious issue"
    And I click the "Continue" button
    Then I should see "What you’re asking the court to decide about the children"
    And I should see "Decide who they live with and when"
    And I should see "This is known as a Child Arrangements Order."
    And I should see "A religious issue"
    And I should see "This is known as a Specific Issue Order."
    Then I click the "Continue" link
    Then I should see "Is there anything else you are asking the court to decide, specifically to protect the safety of you or the children?"
    And I choose "No"
    Then I should see "Going to court"
    And I should see "What happens at court"
    And I should see "Changing or enforcing an order"
    And I should see "Representing yourself in court"
    And I should see "Domestic violence or abuse and child abuse"
    And I check "I understand what’s involved if I decide to go to court"
    And I click the "Continue" button
    Then I should see "Enter the names of the children"
    And I fill in "First name(s)" with "Alistair"
    And I fill in "Last name(s)" with "Doe"
    And I click the "Continue" button
    Then I should see "Provide details for Alistair Doe"
    And I enter the date 1-1-2023
    And I choose "Male"
    And I click the "Continue" button
    Then I should see "Which of the decisions you’re asking the court to resolve relate to Alistair Doe?"
    And I check "Decide who they live with and when"
    And I check "A religious issue"
    And I click the "Continue" button
    Then I should see "Is there a Special Guardianship Order in force in relation to Alistair Doe?"
    And I choose "Yes"
    Then I should see "Parental responsibility for Alistair Doe"
    And I fill in "State everyone who has parental responsibility for Alistair Doe and how they have parental responsibility." with "Me and the respondent"
    And I click the "Continue" button
    Then I should see "Further information"
    And I choose "Yes" for all options on this page
    And I fill in "State which child and the name of the local authority and social worker, if known" with "Alistair Doe knows Jane Doe from London"
    And I click the "Continue" button
    Then I should see "Do you or any respondents have other children who are not part of this application?"
    And I choose "No"
    Then I should see "Enter your name"
    And I fill in "First name(s)" with "June"
    And I fill in "Last name(s)" with "Doe"
    And I click the "Continue" button
    Then I should see "Keeping your contact details private"
    And I choose "I don't know"
    Then I should see "Keeping your contact details private"
    And I choose "No"
    Then I should see "The court will not keep your contact details private"
    And I click the "Continue" link
    Then I should see "Provide details for June Doe"
    And I click the radio button "Yes"
    And I fill in "Enter your previous name" with "Janie Doe"
    And I click the radio button "Female"
    And I enter the date 1-1-1990
    And I fill in "Your place of birth" with "Windsor"
    And I click the "Continue" button
    Then I should see "What is June Doe's relationship to Alistair Doe?"
    And I choose "Mother"
    Then I should see "Address of June Doe"
    And I click the "I live outside the UK" link
    Then I should see "Address details of June Doe"
    And I fill in "Building and street" with "Buckingham Palace"
    And I fill in "Town or city" with "London"
    And I fill in "Country" with "United Kingdom"
    And I fill in "Postcode" with "SW1A 1AA"
    And I click the radio button "Yes"
    And I click the "Continue" button
    Then I should see "Contact details of June Doe"
    And I click the radio button "I can provide an email address"
    And I fill in "Your email address" with "june@gmail.com"
    And I fill in "Your home phone" with "00000000000"
    And I click the radio button "I can provide a mobile phone number"
    And I fill in "Your mobile phone" with "00000000000"
    And I click the radio button "No, the court cannot leave me a voicemail"
    And I click the "Continue" button
    Then I should see "Will you be legally represented by a solicitor in these proceedings?"
    And I choose "Yes"