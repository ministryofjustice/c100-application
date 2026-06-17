@end-to-end
Feature: Testing C100 end to end

  Background: Bypassing postcode page
    Given I have started an application
    Then I should be on the consent order page

  Scenario: Child arrangements order (MIAM) (path one: exemption with no evidence)
    When I submit that I have a MIAM exemption
    And evidence "isn't" provided for the MIAM exemption
    Then I should be taken to the safety concerns page
    When I submit that I have no safety concerns about the children
    Then I should be taken to the petition orders page
    When I ask the court to decide on the following issues: "who the children live with and when"
    Then I should see the child arrangements order details for: "who the children live with and when"
    And I continue to the next step
    Then I should be taken to the going to court page
    When I submit that I understand the process of going to court
    And I submit that I have tried all alternative ways to reach an agreement
    Then I should be taken to the children details page
    When I submit the details for a "2" year old child
    And I submit that the "Father" has parental responsibility for the child
    And I submit that I don't know any additional details for the child
    And I submit that I "don't" have other children
    Then I should be taken to the applicant details page
    When I complete the applicant details journey
    Then I should be taken to the solicitor details page
    When I submit the solicitor details
    Then I should be taken to the respondent details page
    When I submit the respondent details
    Then I should be taken to the other party details page
    When I submit that there "aren't" any other people who should know about the application
    Then I should be taken to the child residence details page
    When I submit the child lives with "John Doe Senior"
    Then I should be taken to the previous court proceedings page
    When I submit details of previous court proceedings
    Then I should be taken to the existing court order page
    When I submit that there "isn't" a court order requiring permission to make this application
    Then I should be taken to the urgent hearing page
    When I submit that I "don't" require an urgent and without notice hearing
    Then I should be taken to the international resident page
    When I submit the international issues details
    Then I should be taken to the reason for application page
    When I submit my reason for the application as "I fear for the safety of Jane Doe Jnr and I want her to be safe"
    Then I should be taken to the litigation capacity page
    When I submit that there "aren't" factors that may affect any adult in this application taking part in the court proceedings
    Then I should be taken to the attending court page
    When I submit that I have no issues attending court
    And I submit that I require special assistance when attending court: "We need lots of light"
    Then I should be taken to the application submission page
    When I submit the application with email "john@gmail.com"
    And I pay using Help With Fees with reference "HWF-123-456"
    Then I should be taken to the Check Your Answers page
    And I should see they have made an application related to a child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order
    And I should see the children "aren't" involved in any emergency protection, care of proceedings
    And I should see they "haven't" been to mediation through the mediation voucher scheme
    And I should see they haven't attended MIAM
    And I should see they "haven't" got safety concerns about the children
    And I should see they want the court to decide: "Decide who they live with and when"
    And I should see that all alternatives "have" been tried
    And I should see the children details:
      | full_name     | age        | sex    | child_orders             | special_guardianship | parental_responsibility |
      | John Smith Jr | 2         | Male   | Child Arrangements Order | No                   | Father                  |
    And I should see the children "might be" known to other social services
    And I should see the applicant personal details
      | refuge | privacy_known | contact_details_private | full_name       | age        | sex  | birthplace | relationship_to_child |
      | No     | Yes           | No                      | John Doe Senior | 26         | Male | Manchester | Father                |
    And I should see the applicant address and contact details:
      | address                             | lived_at_5_years | email_provided | email          | phone_number | voicemail_consent                    |
      | Test street, London, United Kingdom | Yes              | Yes            | john@email.com | 00000000000  | Yes, the court can leave a voicemail |
    And I should see the applicant "does" have a solicitor
    And I should see the solicitor details:
      | full_name        | firm_name        | address                                          | email            | phone_number | dx_number   |
      | Annalise Keating | Keating Law Firm | Windsor Castle, Windsor, United Kingdom, SL4 1QF | annalise@law.com | 00000000000  | 00000000000 |
    And I should see the respondents details:
      | full_name | age        | sex    | relationship | address                                 | lived_at_5_years | email            | phone_number |
      | Jane Doe  | 30         | Female | Mother       | Windsor Castle, Windsor, United Kingdom | Yes              | jane@hotmail.com | 00000000000  |
    And I should see there "aren't" other people who need to be informed of the application
    And I should see the children residence details:
      | child_name    | residence       |
      | John Smith Jr | John Doe Senior |
    And I should see details for other proceedings involving the children:
      | child_name    | court_name    | date | order_type    | previous_details |
      | John Smith Jr | London Court  | 2020 | Legal hearing | Lasted for weeks |
    And I should see an urgent hearing "isn't" requested
    And I should see a without notice hearing "isn't" requested
    And I should see the life of someone significant to the child "isn't" outside the UK
    And I should see another person in this application "could" apply for an order outside the UK
    And I should see a request for information involving the children "hasn't" been made outside the UK
    And I should see the reason for application is "I fear for the safety of Jane Doe Jnr and I want her to be safe"
    And I should see there "isn't" a court order requiring permission to make this application
    And I should see there "aren't" factors that may affect any adult in this application taking part in the court proceedings
    And I should see there "aren't" people who need an intermediary to help them in court
    And I should see there "aren't" special language requirements
    And I should see there "aren't" specific safety arrangements specified for the court
    And I should see there "are" special facilities needed when attending court
    And I should see the email for submitting an application to court is "john@gmail.com"
    And I should see the payment type "Help with fees"
    And I should see the HwF reference number is "HWF-123-456"
    And I should see the statement of truth

  Scenario: Child arrangements order (MIAM) (path two: exemption with evidence upload)
    When I submit that I have a MIAM exemption
    And evidence "is" provided for the MIAM exemption
    Then I should be taken to the safety concerns page
    When I submit that I have abduction concerns about the children
    And I submit that I "don't" have concerns about drug, alcohol or substance abuse
    And I submit that I "don't" have abuse or physical abuse concerns about the children
    And I submit that I "do" have financial concerns about the children
    And I submit that I "don't" have psychological and emotional abuse concerns about the children
    And I submit that I "do" have other abuse concerns about the children
    Then I should be taken to the applicant abuse concerns page
    When I submit that I don't have any safety concerns about myself
    Then I should be taken to the petition orders page
    When I ask the court to decide on the following issues: "who the children live with and when"
    Then I should see the child arrangements order details for: "who the children live with and when"
    And I continue to the next step
    Then I should be taken to the petition protection page
    When I submit that I want the court to also decide "This is what I want resolved"
    Then I should be taken to the going to court page
    When I submit that I understand the process of going to court
    Then I should be taken to the children details page
    When I submit the details for a "2" year old child
    And I submit that the "Father" has parental responsibility for the child
    And I submit that I don't know any additional details for the child
    And I submit that I "don't" have other children
    Then I should be taken to the applicant details page
    When I complete the applicant details journey
    Then I should be taken to the solicitor details page
    When I submit that I "don't" have a solicitor
    Then I should be taken to the respondent details page
    When I submit the respondent details
    Then I should be taken to the other party details page
    When I submit that there "aren't" any other people who should know about the application
    Then I should be taken to the child residence details page
    When I submit the child lives with "John Doe Senior"
    Then I should be taken to the previous court proceedings page
    When I submit that there "hasn't" been any court proceedings about the children
    Then I should be taken to the existing court order page
    When I submit that there "isn't" a court order requiring permission to make this application
    Then I should be taken to the urgent hearing page
    When I submit that I "don't" require an urgent and without notice hearing
    Then I should be taken to the international resident page
    When I submit that there isn't any international issues in this application
    Then I should be taken to the reason for application page
    When I submit my reason for the application as "I fear for the safety of Jane Doe Jnr and I want her to be safe"
    Then I should be taken to the litigation capacity page
    When I submit that there "aren't" factors that may affect any adult in this application taking part in the court proceedings
    Then I should be taken to the attending court page
    When I submit that I have no issues attending court
    And I submit that I don't require special assistance when attending court
    Then I should be taken to the application submission page
    And I submit the application with email "john@gmail.com"
    And I pay using Help With Fees with reference "HWF-123-456"
    Then I should be taken to the Check Your Answers page
    And I should see they have made an application related to a child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order
    And I should see the children "aren't" involved in any emergency protection, care of proceedings
    And I should see they "haven't" been to mediation through the mediation voucher scheme
    And I should see they "haven't" attended a MIAM
    And I should see they have got a valid exemption: "You’re applying for a without notice hearing"
    And I should see the details provided for the exemption are "exemption reason"
    And I should see an attachment presenting MIAM exemption evidence "is" present
    #And I should see they "have" got safety concerns about the children
    And I should see they have safety concerns with the children about: "abduction, financial abuse, other abuse"
    And I should see "No, I do not want the other person to spend time with the children"
    And I should see they want the court to decide: "Decide who they live with and when"
    And I should see the children details:
      | full_name     | age | sex    | child_orders             | special_guardianship | parental_responsibility |
      | John Smith Jr | 2   | Male   | Child Arrangements Order | No                   | Father                  |
    And I should see the children "might be" known to other social services
    And I should see the applicant personal details
      | refuge | privacy_known | contact_details_private | full_name       | age | sex  | birthplace | relationship_to_child |
      | No     | Yes           | No                      | John Doe Senior | 26  | Male | Manchester | Father                |
    And I should see the applicant address and contact details:
      | address                             | lived_at_5_years | email_provided | email          | phone_number | voicemail_consent                    |
      | Test street, London, United Kingdom | Yes              | Yes            | john@email.com | 00000000000  | Yes, the court can leave a voicemail |
    And I should see the applicant "doesn't" have a solicitor
    And I should see the respondents details:
      | full_name | age | sex    | relationship | address                                 | lived_at_5_years | email            | phone_number |
      | Jane Doe  | 30  | Female | Mother       | Windsor Castle, Windsor, United Kingdom | Yes              | jane@hotmail.com | 00000000000  |
    And I should see there "aren't" other people who need to be informed of the application
    And I should see the children residence details:
      | child_name    | residence       |
      | John Smith Jr | John Doe Senior |
    And I should see the children "haven't" been involved in other proceedings
    And I should see an urgent hearing "isn't" requested
    And I should see a without notice hearing "isn't" requested
    And I should see the life of someone significant to the child "isn't" outside the UK
    And I should see another person in this application "couldn't" apply for an order outside the UK
    And I should see a request for information involving the children "hasn't" been made outside the UK
    And I should see the reason for application is "I fear for the safety of Jane Doe Jnr and I want her to be safe"
    And I should see there "isn't" a court order requiring permission to make this application
    And I should see there "aren't" factors that may affect any adult in this application taking part in the court proceedings
    And I should see there "aren't" people who need an intermediary to help them in court
    And I should see there "aren't" special language requirements
    And I should see there "aren't" specific safety arrangements specified for the court
    And I should see there "aren't" special facilities needed when attending court
    And I should see the email for submitting an application to court is "john@gmail.com"
    And I should see the payment type "Help with fees"
    And I should see the HwF reference number is "HWF-123-456"
    And I should see the statement of truth
    And I click the radio button "I believe that the facts stated in this form and any continuation sheet are true"
    And I fill in "Enter your full name" with "John Doe"
    And I click the "Submit application" button
    Then I should see "Your application has been submitted"
    And I should see "Your reference code is:"
    And I should see "Download a copy of your application"
    And I should see "Download your application"

  Scenario: Child arrangements order (MIAM) (path three: 'Yes' to 'Have you attended a MIAM?')
    When I submit that I have attended a MIAM
    Then I should be taken to the safety concerns page
    When I submit that I have no safety concerns about the children
    Then I should be taken to the petition orders page
    When I ask the court to decide on the following issues: "who the children live with and when"
    Then I should see the child arrangements order details for: "who the children live with and when"
    And I continue to the next step
    Then I should be taken to the going to court page
    When I submit that I understand the process of going to court
    And I submit that I have tried all alternative ways to reach an agreement
    Then I should be taken to the children details page
    When I submit the details for a "2" year old child
    And I submit that the "Father" has parental responsibility for the child
    And I submit that I don't know any additional details for the child
    And I submit that I "don't" have other children
    Then I should be taken to the applicant details page
    When I complete the applicant details journey
    Then I should be taken to the solicitor details page
    When I submit the solicitor details
    Then I should be taken to the respondent details page
    When I submit the respondent details
    Then I should be taken to the other party details page
    When I submit that there "aren't" any other people who should know about the application
    Then I should be taken to the child residence details page
    When I submit the child lives with "John Doe Senior"
    Then I should be taken to the previous court proceedings page
    When I submit details of previous court proceedings
    Then I should be taken to the existing court order page
    When I submit that there "isn't" a court order requiring permission to make this application
    Then I should be taken to the urgent hearing page
    When I submit that I "don't" require an urgent and without notice hearing
    Then I should be taken to the international resident page
    When I submit the international issues details
    Then I should be taken to the reason for application page
    When I submit my reason for the application as "I fear for the safety of Jane Doe Jnr and I want her to be safe"
    Then I should be taken to the litigation capacity page 
    When I submit that there "aren't" factors that may affect any adult in this application taking part in the court proceedings
    Then I should be taken to the attending court page
    When I submit that I have no issues attending court
    And I submit that I require special assistance when attending court: "We need lots of light"
    Then I should be taken to the application submission page
    When I submit the application with email "john@gmail.com"
    And I pay using Help With Fees with reference "HWF-123-456"
    Then I should be taken to the Check Your Answers page
    And I should see they have made an application related to a child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order
    And I should see the children "aren't" involved in any emergency protection, care of proceedings
    And I should see they "haven't" been to mediation through the mediation voucher scheme
    And I should see they "have" attended a MIAM
    And I should see they have a document signed by the mediator
    And I should see they "haven't" got safety concerns about the children
    And I should see they want the court to decide: "Decide who they live with and when"
    And I should see they have made an application related to a child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order
    And I should see the children "aren't" involved in any emergency protection, care of proceedings
    And I should see they "haven't" been to mediation through the mediation voucher scheme
    And I should see they have attended MIAM
    And I should see they have a document signed by the mediator
    And I should see they "haven't" got safety concerns about the children
    And I should see they want the court to decide: "Decide who they live with and when"
    And I should see the children details:
      | full_name     | age | sex    | child_orders             | special_guardianship | parental_responsibility |
      | John Smith Jr | 2   | Male   | Child Arrangements Order | No                   | Father                  |
    And I should see the children "might be" known to other social services
    And I should see the applicant personal details
      | refuge | privacy_known | contact_details_private | full_name       | age | sex  | birthplace | relationship_to_child |
      | No     | Yes           | No                      | John Doe Senior | 26  | Male | Manchester | Father                |
    And I should see the applicant address and contact details:
      | address                             | lived_at_5_years | email_provided | email          | phone_number | voicemail_consent                    |
      | Test street, London, United Kingdom | Yes              | Yes            | john@email.com | 00000000000  | Yes, the court can leave a voicemail |
    And I should see the applicant "does" have a solicitor
    And I should see the solicitor details:
      | full_name        | firm_name        | address                                          | email            | phone_number | dx_number   |
      | Annalise Keating | Keating Law Firm | Windsor Castle, Windsor, United Kingdom, SL4 1QF | annalise@law.com | 00000000000  | 00000000000 |
    And I should see the respondents details:
      | full_name | age | sex    | relationship | address                                 | lived_at_5_years | email            | phone_number |
      | Jane Doe  | 30  | Female | Mother       | Windsor Castle, Windsor, United Kingdom | Yes              | jane@hotmail.com | 00000000000  |
    And I should see there "aren't" other people who need to be informed of the application
    And I should see the children residence details:
      | child_name    | residence       |
      | John Smith Jr | John Doe Senior |
    And I should see the children "have" been involved in other proceedings
    And I should see details for other proceedings involving the children:
      | child_name    | court_name    | date | order_type    | previous_details |
      | John Smith Jr | London Court  | 2020 | Legal hearing | Lasted for weeks |
    And I should see an urgent hearing "isn't" requested
    And I should see a without notice hearing "isn't" requested
    And I should see the life of someone significant to the child "isn't" outside the UK
    And I should see another person in this application "could" apply for an order outside the UK
    And I should see a request for information involving the children "hasn't" been made outside the UK
    And I should see the reason for application is "I fear for the safety of Jane Doe Jnr and I want her to be safe"
    And I should see there "isn't" a court order requiring permission to make this application
    And I should see there "aren't" factors that may affect any adult in this application taking part in the court proceedings
    And I should see there "aren't" people who need an intermediary to help them in court
    And I should see there "aren't" special language requirements
    And I should see there "aren't" specific safety arrangements specified for the court
    And I should see there "are" special facilities needed when attending court
    And I should see the email for submitting an application to court is "john@gmail.com"
    And I should see the payment type "Help with fees"
    And I should see the HwF reference number is "HWF-123-456"
    And I should see the statement of truth
    And I click the radio button "The applicant believes that the facts stated in this form and any continuation sheets are true. I am authorised by the applicant to sign this statement. This option should only selected if the legal representative is signing the form on behalf of the applicant."
    And I fill in "Enter your full name" with "Annalise Keating"
    And I click the radio button "I am the solicitor. The applicant believes that the facts stated in this application are true and I have been given the authority to make this declaration."
    And I click the "Submit application" button
    Then I should see "Your application has been submitted"
    And I should see "Your reference code is:"
    And I should see "Download a copy of your application"
    And I should see "Download your application"

  Scenario: Child arrangements order (MIAM) (path four: 'Yes' to 'Have you attended a MIAM?')
    When I submit that I have a MIAM with a child protection case
    And I navigate back to the consent order page
    When I submit that I have attended a MIAM
    Then I should be taken to the safety concerns page
    When I submit that I have abduction concerns about the children
    And I submit that I "do" have concerns about drug, alcohol or substance abuse
    And I submit that I "don't" have abuse or physical abuse concerns about the children
    And I submit that I "do" have financial concerns about the children
    And I submit that I "do" have psychological and emotional abuse concerns about the children
    And I submit that I "do" have other abuse concerns about the children
    Then I should be taken to the applicant abuse concerns page
    When I submit that I "haven't" been abused by the respondent
    And I submit that I "have" been physically abused by the respondent
    And I submit that I "have" been financially abused by the respondent
    And I submit that I "haven't" been psychologically and emotionally abused by the respondent
    And I submit that I "don't" have any other concerns about my welfare
    And I submit that I "haven't" had or currently have court orders made for my protection
    And I submit that I "don't" agree to the children having contact with the other people in this application
    Then I should be taken to the petition orders page 
    When I ask the court to decide on the following issues: "who the children live with and when, how much time they spend with each person"
    Then I should see the child arrangements order details for: "who the children live with and when, how much time they spend with each person"
    And I continue to the next step
    Then I should be taken to the petition protection page
    When I submit that I want the court to also decide "I want the court to decide whether the respondent should give compensation"
    Then I should be taken to the going to court page
    When I submit that I understand the process of going to court
    Then I should be taken to the children details page
    When I submit the details for a "2" year old child
    And I submit that the "Mother" has parental responsibility for the child
    And I submit that I don't know any additional details for the child
    And I submit that I "do" have other children
    And I enter details for another child who is "3" years old
    When I complete the applicant details journey keeping my contact details private
    Then I should be taken to the solicitor details page
    When I submit that I "don't" have a solicitor
    Then I should be taken to the respondent details page
    When I submit the respondent details with an additional child
    When I submit that there "are" any other people who should know about the application
    And I submit the other party details with an additional child
    Then I should be taken to the child residence details page
    When I submit the child lives with "Jane Doe"
    Then I should be taken to the previous court proceedings page
    When I submit details of previous court proceedings with an additional child
    Then I should be taken to the existing court order page
    When I submit that there "isn't" a court order requiring permission to make this application
    Then I should be taken to the urgent hearing page
    When I submit that I "don't" require an urgent and without notice hearing
    Then I should be taken to the international resident page
    When I submit the international issues details with an international resident
    Then I should be taken to the reason for application page
    When I submit my reason for the application as "I fear for Emily & John's safety, but particularly Emily's"
    Then I should be taken to the litigation capacity page
    When I submit that there "are" factors that may affect any adult in this application taking part in the court proceedings
    And I submit that there "aren't" factors affecting ability to participate
    Then I should be taken to the attending court page
    When I submit the attending court details
    Then I should be taken to the application submission page
    When I submit the application with email "jane_doe@gmail.com"
    And I pay using Help With Fees with reference "HWF-123-456"
    Then I should be taken to the Check Your Answers page
    And I should see they have made an application related to a child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order
    And I should see the children "aren't" involved in any emergency protection, care of proceedings
    And I should see they "haven't" been to mediation through the mediation voucher scheme
    And I should see they "have" attended a MIAM
    And I should see they have a document signed by the mediator
    # And I should see they "have" got safety concerns about the children
    And I should see they have safety concerns with the children about: "financial abuse, psychological abuse, emotional abuse, other abuse, abduction, drug alcohol or substance abuse"
    And I should see they have safety concerns with themselves about: "physical abuse, financial abuse"
    And I should see "No, I do not want the other person to spend time with the children"
    And I should see they want the court to decide: "Decide who they live with and when, Decide how much time they spend with each person"
    And I should see the children details:
      | full_name      | age | sex      | child_orders             | special_guardianship | parental_responsibility |
      | John Smith Jr  | 2   | Male     | Child Arrangements Order | No                   | Mother                  |
    And I should see the children "might be" known to other social services
    And I should see the applicant personal details
      | refuge | privacy_known | contact_details_private | full_name       | age | sex    | birthplace | relationship_to_child |
      | No     | Unknown       | Current address         | Jane Doe        | 30  | Female | London     | Mother                |
    And I should see the applicant address and contact details:
      | address                                 | lived_at_5_years | email_provided | email              | phone_number | voicemail_consent                    |
      | Windsor Castle, Windsor, United Kingdom | Yes              | Yes            | jane_doe@gmail.com | 00000888888  | Yes, the court can leave a voicemail |
    And I should see the applicant's relationship to "John Smith Jr" is "Mother"
    And I should see the applicant's relationship to "Jane Smith" is "Mother"
    And I should see the applicant "doesn't" have a solicitor
    And I should see the respondents details:
      | full_name | age | sex    | relationship | address                                 | lived_at_5_years | email                | phone_number |
      | John Doe  | 35  | Male   | Father       | Windsor Castle, Windsor, United Kingdom | No               | john-doe@hotmail.com | 00000999999  |
    #And I should see the respondent "might not have" lived at that address for more than 5 years
    And I should see the respondent's relationship to "John Smith Jr" is "Father"
    And I should see the respondent's relationship to "Jane Smith" is "Father"
    And I should see there "are" other people who need to be informed of the application
    And I should see the other party's name is "Judy Sitter"
    And I should see the other party's gender is "Female"
    And I should see the other party is "35" years of age
    And I should see the other party's address is "10 Downing Street, London, United Kingdom, SW1A 2AA"
    And I should see the other party's relationship to "John Smith Jr" is "Caregiver"
    And I should see the other party's relationship to "Jane Smith" is "Caregiver"
    And I should see the children residence details:
      | child_name    | residence |
      | John Smith Jr | Jane Doe  |
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
    And I should see there "isn't" a court order requiring permission to make this application
    And I should see there "are" factors that may affect any adult in this application taking part in the court proceedings
    And I should see there "are" people who need an intermediary to help them in court
    And I should see the details provided for the intermediary are "Needed for the respondent"
    #And I should see there "are" special language requirements
    And I should see there "are" specific safety arrangements specified for the court
    And I should see there "aren't" special facilities needed when attending court
    And I should see the email for submitting an application to court is "jane_doe@gmail.com"
    And I should see the payment type "Help with fees"
    And I should see the HwF reference number is "HWF-123-456"
    And I should see the statement of truth
    And I click the radio button "I believe that the facts stated in this form and any continuation sheet are true"
    And I fill in "Enter your full name" with "John Doe"
    And I click the "Submit application" button
    Then I should see "Your application has been submitted"
    And I should see "Your reference code is:"
    And I should see "Download a copy of your application"
    And I should see "Download your application"

  Scenario: Skip child arrangements order (MIAM) (path five)
    When I submit that I have a MIAM with a child protection case
    Then I should be taken to the safety concerns page
    When I submit that I have no safety concerns about the children
    Then I should be taken to the petition orders page
    When I ask the court to decide on the following issues: "who the children live with and when"
    Then I should see the child arrangements order details for: "who the children live with and when"
    And I continue to the next step
    Then I should be taken to the going to court page
    When I submit that I understand the process of going to court
    And I submit that I have tried all alternative ways to reach an agreement
    Then I should be taken to the children details page
    And I submit the details for a "2" year old child
    And I submit that the "Father" has parental responsibility for the child
    And I submit that I don't know any additional details for the child
    And I submit that I "don't" have other children
    Then I should be taken to the applicant details page
    When I complete the applicant details journey
    Then I should be taken to the solicitor details page
    When I submit the solicitor details
    Then I should be taken to the respondent details page
    When I submit the respondent details
    Then I should be taken to the other party details page
    When I submit that there "aren't" any other people who should know about the application
    Then I should be taken to the child residence details page
    When I submit the child lives with "John Doe Senior"
    Then I should be taken to the previous court proceedings page
    When I submit details of previous court proceedings
    Then I should be taken to the existing court order page
    When I submit that there "isn't" a court order requiring permission to make this application
    Then I should be taken to the urgent hearing page
    When I submit that I "don't" require an urgent and without notice hearing
    Then I should be taken to the international resident page
    When I submit the international issues details
    Then I should be taken to the reason for application page
    When I submit my reason for the application as "I fear for the safety of Jane Doe Jnr and I want her to be safe"
    Then I should be taken to the litigation capacity page
    When I submit that there "aren't" factors that may affect any adult in this application taking part in the court proceedings
    Then I should be taken to the attending court page
    When I submit that I have no issues attending court
    And I submit that I require special assistance when attending court: "We need lots of light"
    Then I should be taken to the application submission page
    When I submit the application with email "john@gmail.com"
    And I pay using Help With Fees with reference "HWF-123-456"
    Then I should be taken to the Check Your Answers page
    And I should see they have made an application related to a child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order
    And I should see the children "are" involved in any emergency protection, care of proceedings
    And I should see they "haven't" got safety concerns about the children
    And I should see they want the court to decide: "Decide who they live with and when"
    And I should see the children details:
      | full_name     | age | sex    | child_orders             | special_guardianship | parental_responsibility |
      | John Smith Jr | 2   | Male   | Child Arrangements Order | No                   | Father                  |
    And I should see the children "might be" known to other social services
    And I should see the applicant personal details
      | refuge | privacy_known | contact_details_private | full_name       | age | sex  | birthplace | relationship_to_child |
      | No     | Yes           | No                      | John Doe Senior | 26  | Male | Manchester | Father                |
    And I should see the applicant address and contact details:
      | address                             | lived_at_5_years | email_provided | email          | phone_number | voicemail_consent                    |
      | Test street, London, United Kingdom | Yes              | Yes            | john@email.com | 00000000000  | Yes, the court can leave a voicemail |
    And I should see the applicant "does" have a solicitor
    And I should see the solicitor details:
      | full_name        | firm_name        | address                                          | email            | phone_number | dx_number   |
      | Annalise Keating | Keating Law Firm | Windsor Castle, Windsor, United Kingdom, SL4 1QF | annalise@law.com | 00000000000  | 00000000000 |
    And I should see the respondents details:
      | full_name | age | sex    | relationship | address                                 | lived_at_5_years | email            | phone_number |
      | Jane Doe  | 30  | Female | Mother       | Windsor Castle, Windsor, United Kingdom | Yes              | jane@hotmail.com | 00000000000  |
    And I should see there "aren't" other people who need to be informed of the application
    And I should see the children residence details:
      | child_name    | residence       |
      | John Smith Jr | John Doe Senior |
    And I should see the children "have" been involved in other proceedings
    And I should see details for other proceedings involving the children:
      | child_name    | court_name    | date | order_type    | previous_details |
      | John Smith Jr | London Court  | 2020 | Legal hearing | Lasted for weeks |
    And I should see an urgent hearing "isn't" requested
    And I should see a without notice hearing "isn't" requested
    And I should see the life of someone significant to the child "isn't" outside the UK
    And I should see another person in this application "could" apply for an order outside the UK
    And I should see a request for information involving the children "hasn't" been made outside the UK
    And I should see the reason for application is "I fear for the safety of Jane Doe Jnr and I want her to be safe"
    And I should see there "isn't" a court order requiring permission to make this application
    And I should see there "aren't" factors that may affect any adult in this application taking part in the court proceedings
    And I should see there "aren't" people who need an intermediary to help them in court
    And I should see there "aren't" special language requirements
    And I should see there "aren't" specific safety arrangements specified for the court
    And I should see there "are" special facilities needed when attending court
    And I should see the email for submitting an application to court is "john@gmail.com"
    And I should see the payment type "Help with fees"
    And I should see the HwF reference number is "HWF-123-456"
    And I should see the statement of truth
    And I click the radio button "I believe that the facts stated in this form and any continuation sheet are true"
    And I fill in "Enter your full name" with "John Doe"
    And I click the radio button "I am the applicant and I believe that the facts stated in this application are true."
    And I click the "Submit application" button
    Then I should see "Your application has been submitted"
    And I should see "Your reference code is:"
    And I should see "Download a copy of your application"
    And I should see "Download your application"

  Scenario: Consent order (path six)
    When I submit that I have a Consent Order with a child protection case
    Then I should be taken to the safety concerns page
    When I submit that I "don't" have abduction concerns about the children
    And I submit that I "don't" have concerns about drug, alcohol or substance abuse
    And I submit that I "do" have domestic abuse or child concerns about the children
    And I submit that I "don't" have abuse or physical abuse concerns about the children
    And I submit that I "do" have financial concerns about the children
    And I submit that I "do" have psychological and emotional abuse concerns about the children
    And I submit that I "don't" have other abuse concerns about the children
    Then I should be taken to the applicant abuse concerns page
    And I submit that I "have" been abused by the respondent
    And I submit that I "have" been physically abused by the respondent
    And I submit that I "have" been financially abused by the respondent
    And I submit that I "have" been psychologically and emotionally abused by the respondent
    And I submit that I "don't" have any other concerns about my welfare
    And I submit that I "haven't" had or currently have court orders made for my protection
    And I submit that I "don't" agree to the children having contact with the other people in this application
    Then I should be taken to the petition orders page
    When I ask the court to decide on the following issues: "who the children live with and when, a religious issue"
    Then I should see the child arrangements order details for: "who the children live with and when"
    Then I should see the specific issue order details for: "a religious issue"
    And I continue to the next step
    Then I should be taken to the petition protection page
    When I submit that I am not asking the court to decide on any other issues
    Then I should be taken to the going to court page
    When I submit that I understand the process of going to court
    Then I should be taken to the children details page
    When I submit the details for a "6" year old child with a special guardianship order
    And I submit that the "Me and the respondent" has parental responsibility for the child
    And I submit that the children have a child protection plan and are known to social services: "Alistair Doe knows Jane Doe from London"
    And I submit that I "don't" have other children
    Then I should be taken to the applicant details page
    When I complete the applicant details journey
    Then I should be taken to the solicitor details page
    When I submit the solicitor details
    Then I should be taken to the respondent details page
    When I submit the respondent details
    Then I should be taken to the other party details page
    When I submit that there "are" any other people who should know about the application
    And I submit the other party details
    Then I should be taken to the child residence details page
    When I submit the child lives with "John Doe Senior"
    Then I should be taken to the previous court proceedings page
    When I submit that there "hasn't" been any court proceedings about the children
    Then I should be taken to the existing court order page
    When I submit that there "isn't" a court order requiring permission to make this application
    Then I should be taken to the urgent hearing page
    When I submit that I "do" require an urgent and without notice hearing
    Then I should be taken to the international resident page
    When I submit that there isn't any international issues in this application
    Then I should be taken to the reason for application page
    When I submit my reason for the application as "Alistair is in grave danger because of Jake Gyllenhaal and I need to rescue him"
    Then I should be taken to the litigation capacity page
    When I submit that there "are" factors that may affect any adult in this application taking part in the court proceedings
    And I submit that there "aren't" factors affecting ability to participate
    Then I should be taken to the attending court page
    When I submit the attending court details with safety arrangements
    Then I should be taken to the application submission page
    And I submit the application with email "june@gmail.com"
    And I pay using Help With Fees with reference "HWF-123-456"
    Then I should be taken to the Check Your Answers page
    And I should see they have made a consent order application
    And I should see the children "are" involved in any emergency protection, care of proceedings
    #And I should see they "have" got safety concerns about the children
    And I should see they have safety concerns with the children about: "financial abuse, psychological abuse, emotional abuse"
    And I should see they have safety concerns with themselves about: "sexual abuse, physical abuse, financial abuse, psychological abuse, emotional abuse"
    And I should see "No, I do not want the other person to spend time with the children"
    And I should see they want the court to decide: "Decide who they live with and when, A religious issue"
    And I should see they want the court to resolve an issue about: "A religious issue"
    And I should see the child's full name is "Alistair Doe"
    And I should see the child's gender is "Male"
    And I should see the child is "6" years old
    And I should see the people who have parental responsibility for the child are: "Me and the respondent"
    And I should see the children "are" known to other social services
    And I should see the applicant personal details
      | refuge | privacy_known | contact_details_private | full_name       | age | sex  | birthplace | relationship_to_child |
      | No     | Yes           | No                      | John Doe Senior | 26  | Male | Manchester | Father                |
    And I should see the applicant address and contact details:
      | address                             | lived_at_5_years | email_provided | email          | phone_number | voicemail_consent                    |
      | Test street, London, United Kingdom | Yes              | Yes            | john@email.com | 00000000000  | Yes, the court can leave a voicemail |
    And I should see the applicant "does" have a solicitor
    And I should see the solicitor details:
      | full_name        | firm_name        | address                                          | email            | phone_number | dx_number   |
      | Annalise Keating | Keating Law Firm | Windsor Castle, Windsor, United Kingdom, SL4 1QF | annalise@law.com | 00000000000  | 00000000000 |
    And I should see the respondents details:
      | full_name | age | sex    | relationship | address                                 | lived_at_5_years | email            | phone_number |
      | Jane Doe  | 30  | Female | Mother       | Windsor Castle, Windsor, United Kingdom | Yes              | jane@hotmail.com | 00000000000  |
    And I should see there "are" other people who need to be informed of the application
    And I should see the other party's name is "Cassie Doe"
    And I should see the other party's gender is "Female"
    And I should see the other party is "30" years of age
    And I should see the other party's address is "10 Downing Street, London, United Kingdom, SW1A 2AA"
    And I should see the other party's relationship to "Alistair Doe" is "Caregiver"
    And I should see the child "Alistair Doe" lives with "John Doe Senior"
    And I should see the children "haven't" been involved in other proceedings
    And I should see an urgent hearing "is" requested
    And I should see an urgent hearing is requested because "Alistair is in grave danger because of Jake Gyllenhaal"
    And I should see an urgent hearing is needed: "In the next four weeks"
    And I should see a hearing "isn't" needed within the next 48 hours
    And I should see a without notice hearing "is" requested
    And I should see a without notice hearing is requested because "Alistair is in grave danger because of Jake Gyllenhaal and I need to rescue him"
    And I should see the life of someone significant to the child "isn't" outside the UK
    And I should see another person in this application "couldn't" apply for an order outside the UK
    And I should see a request for information involving the children "hasn't" been made outside the UK
    And I should see the reason for application is "Alistair is in grave danger because of Jake Gyllenhaal and I need to rescue him"
    And I should see there "isn't" a court order requiring permission to make this application
    And I should see there "are" factors that may affect any adult in this application taking part in the court proceedings
    And I should see there "are" people who need an intermediary to help them in court
    And I should see the details provided for the intermediary are "I need someone to communicate between me and the respondent"
    #And I should see there "are" special language requirements
    And I should see there "are" specific safety arrangements specified for the court
    And I should see there "aren't" special facilities needed when attending court
    And I should see the email for submitting an application to court is "june@gmail.com"
    And I should see the payment type "Help with fees"
    And I should see the HwF reference number is "HWF-123-456"
    And I should see the statement of truth
    And I click the radio button "I believe that the facts stated in this form and any continuation sheet are true"
    And I fill in "Enter your full name" with "June Doe"
    And I click the radio button "I am the applicant and I believe that the facts stated in this application are true."
    And I click the "Submit application" button
    Then I should see "Your application has been submitted"
    And I should see "Your reference code is:"
    And I should see "Download a copy of your application"
    And I should see "Download your application"

  Scenario: Existing Court Order (path seven: 'Yes' to 'Have you attended a MIAM?)
    When I submit that I have attended a MIAM
    Then I should be taken to the safety concerns page
    When I submit that I have no safety concerns about the children
    Then I should be taken to the petition orders page
    When I ask the court to decide on the following issues: "who the children live with and when"
    Then I should see the child arrangements order details for: "who the children live with and when"
    And I continue to the next step
    Then I should be taken to the going to court page
    When I submit that I understand the process of going to court
    And I submit that I have tried all alternative ways to reach an agreement
    Then I should be taken to the children details page
    When I submit the details for a "2" year old child
    And I submit that the "Father" has parental responsibility for the child
    And I submit that I don't know any additional details for the child
    And I submit that I "don't" have other children
    Then I should be taken to the applicant details page
    When I complete the applicant details journey
    Then I should be taken to the solicitor details page
    When I submit that I "don't" have a solicitor
    Then I should be taken to the respondent details page
    When I submit the respondent details
    Then I should be taken to the other party details page
    When I submit that there "aren't" any other people who should know about the application
    Then I should be taken to the child residence details page
    When I submit the child lives with "John Doe Senior"
    Then I should be taken to the previous court proceedings page 
    When I submit that there "hasn't" been any court proceedings about the children
    Then I should be taken to the existing court order page
    When I submit that there "is" a court order requiring permission to make this application
    Then I should be taken to the urgent hearing page
    When I submit that I "don't" require an urgent and without notice hearing
    Then I should be taken to the international resident page
    When I submit the international issues details
    Then I should be taken to the reason for application page
    When I submit my reason for the application as "I fear for the safety of Jane Doe Jnr and I want her to be safe"
    Then I should be taken to the litigation capacity page 
    When I submit that there "aren't" factors that may affect any adult in this application taking part in the court proceedings
    Then I should be taken to the attending court page
    When I submit that I have no issues attending court
    And I submit that I require special assistance when attending court: "We need lots of light"
    Then I should be taken to the application submission page
    When I submit the application with email "john@gmail.com"
    And I pay using Help With Fees with reference "HWF-123-456"
    Then I should be taken to the Check Your Answers page
    And I should see they have made an application related to a child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order
    And I should see the children "aren't" involved in any emergency protection, care of proceedings
    And I should see they "haven't" been to mediation through the mediation voucher scheme
    And I should see they have attended MIAM
    And I should see they have a document signed by the mediator
    And I should see they "haven't" got safety concerns about the children
    And I should see they want the court to decide: "Decide who they live with and when"
    And I should see the children details:
      | full_name     | age | sex    | child_orders             | special_guardianship | parental_responsibility |
      | John Smith Jr | 2   | Male   | Child Arrangements Order | No                   | Father                  |
    And I should see the children "might be" known to other social services
    And I should see the applicant personal details
      | refuge | privacy_known | contact_details_private | full_name       | age | sex  | birthplace | relationship_to_child |
      | No     | Yes           | No                      | John Doe Senior | 26  | Male | Manchester | Father                |
    And I should see the applicant address and contact details:
      | address                             | lived_at_5_years | email_provided | email          | phone_number | voicemail_consent                    |
      | Test street, London, United Kingdom | Yes              | Yes            | john@email.com | 00000000000  | Yes, the court can leave a voicemail |
    And I should see the respondents details:
      | full_name | age | sex    | relationship | address                                 | lived_at_5_years | email            | phone_number |
      | Jane Doe  | 30  | Female | Mother       | Windsor Castle, Windsor, United Kingdom | Yes              | jane@hotmail.com | 00000000000  |
    And I should see there "aren't" other people who need to be informed of the application
    And I should see the child "John Smith Jr" lives with "John Doe Senior"
    And I should see the children "haven't" been involved in other proceedings
    And I should see an urgent hearing "isn't" requested
    And I should see a without notice hearing "isn't" requested
    And I should see the life of someone significant to the child "isn't" outside the UK
    And I should see another person in this application "could" apply for an order outside the UK
    And I should see a request for information involving the children "hasn't" been made outside the UK
    And I should see the reason for application is "I fear for the safety of Jane Doe Jnr and I want her to be safe"
    And I should see there "is" a court order requiring permission to make this application
    And I should see the case number of the court order is "12345678"
    And I should see the expiry date of the court order is "2030-01-01"
    And I should see they "have" uploaded their existing court order
    And I should see there "aren't" factors that may affect any adult in this application taking part in the court proceedings
    And I should see there "aren't" people who need an intermediary to help them in court
    And I should see there "aren't" special language requirements
    And I should see there "aren't" specific safety arrangements specified for the court
    And I should see there "are" special facilities needed when attending court
    And I should see the email for submitting an application to court is "john@gmail.com"
    And I should see the payment type "Help with fees"
    And I should see the HwF reference number is "HWF-123-456"
    And I should see the statement of truth
    And I click the radio button "I believe that the facts stated in this form and any continuation sheet are true"
    And I fill in "Enter your full name" with "John Doe"
    And I click the "Submit application" button
    Then I should see "Your application has been submitted"
    And I should see "Your reference code is:"
    And I should see "Download a copy of your application"
    And I should see "Download your application"
