Feature: MIAM mediation change journey
  Background:
    Given I have started an application
    When I visit "steps/miam/acknowledgement"
    Then I should see "Have you previously been to mediation through the mediation voucher scheme?"
    And I choose "Yes"
    Then I should see "Attending a Mediation Information and Assessment Meeting (MIAM)"
    And I check "I understand that I have to attend a MIAM, or a non-court dispute resolution process, or provide a valid reason for not attending."
    And I click the "Continue" button

#  @happy_path
#  Scenario: Applicant attended a MIAM
#    Then I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
#    And I choose "Yes"
#    Then I should see "Have you got a document signed by the mediator?"
#    And I choose "Yes"
#    Then I should see "Upload your MIAM certificate"

  @unhappy_path
  Scenario: Applicant attended a MIAM but lacks the certificate
    Then I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "Yes"
    Then I should see "Have you got a document signed by the mediator?"
    And I choose "No"
    Then I should see "You need to get a document from the mediator"
    Then I should see "Save and come back later"

  @unhappy_path
  Scenario Outline: Applicant did not attend a MIAM and does not have a mediator’s exemption
    Then I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "No"
    Then I should see "Do you have a valid reason for not attending a MIAM?"
    And I choose "<has_valid_reason>"
    Then I should see "<outcome_page_header>"

    Examples:
      | has_valid_reason | outcome_page_header                                       |
      | Yes              | Providing evidence of domestic abuse concerns             |
      | No               | You must attend a MIAM                                    |

  @unhappy_path
  Scenario: Applicant did not attend a MIAM and has not selected a valid reason
    Then I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "No"
    Then I should see "Do you have a valid reason for not attending a MIAM?"
    And I choose "Yes"
    Then I should see "Providing evidence of domestic abuse concerns"
    And I check "None of these"
    And I click the "Continue" button
    Then I should see "Confirming child protection concerns"
    And I check "None of these"
    And I click the "Continue" button
    Then I should see "Confirming why your application is urgent"
    And I check "None of these"
    And I click the "Continue" button
    Then I should see "You’ve already been to a MIAM or are taking part in another form of non-court dispute resolution"
    And I check "None of these"
    And I click the "Continue" button
    Then I should see "Confirming other valid reasons for not attending"
    And I check "None of these"
    And I click the "Continue" button
    Then I should see "You must attend a MIAM"


  @happy_path
  Scenario: Applicant did not attend a MIAM and has selected a misc valid reason
    Then I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "No"
    Then I should see "Do you have a valid reason for not attending a MIAM?"
    And I choose "Yes"
    Then I should see "Providing evidence of domestic abuse concerns"
    And I check "None of these"
    And I click the "Continue" button
    Then I should see "Confirming child protection concerns"
    And I check "None of these"
    And I click the "Continue" button
    Then I should see "Confirming why your application is urgent"
    And I check "None of these"
    And I click the "Continue" button
    Then I should see "You’ve already been to a MIAM or are taking part in another form of non-court dispute resolution"
    And I check "None of these"
    And I click the "Continue" button
    Then I should see "Confirming other valid reasons for not attending"
    And I check "You’re applying for a without notice hearing"
    And I check "You or the prospective respondents are under 18 years old"
    And I click the "Continue" button
    Then I should see "Evidence of MIAM exemption"
    When I choose "Yes"
    Then I should see "Upload your evidence for a MIAM exemption"
    Then I upload a document using the file uploader
    And I click the "Continue" button
    Then I should see "Provide details of exemptions from attending a MIAM"
    Then I fill in "steps-miam-exemptions-exemption-details-form-exemption-details-field" with "details"
    And I click the "Continue" button
    Then I should see "You don’t have to attend a MIAM"
    Then I should see "Other exemptions"
    Then I should see "You’re applying for a without notice hearing"
    Then I should see "You or the prospective respondents are under 18 years old"
    And I click the "Continue" link
    Then I should see "Safety concerns"

  @happy_path @skip
  Scenario: Test timeout for applicant attended a MIAM
    When I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "Yes"
    Then I should see "Have you got a document signed by the mediator?"
    When I wait and click the "Continue" button
    Then I should see "Sorry, you'll have to start again"
    And the time goes back to normal

  @unhappy_path
  Scenario: Test timeout for applicant attended a MIAM but lacks the certificate
    When I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "Yes"
    Then I should see "Have you got a document signed by the mediator?"
    When I wait and click the "Continue" button
    Then I should see "Sorry, you'll have to start again"
    And the time goes back to normal

  @unhappy_path
  Scenario: Test timeout for applicant did not attend a MIAM and does not have a mediator’s exemption
    Then I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "No"
    Then I should see "Do you have a valid reason for not attending a MIAM?"
    Then I wait and click the "Continue" button
    And I should see "Sorry, you'll have to start again"
    And the time goes back to normal

  @unhappy_path
  Scenario: Test timeout for applicant did not attend a MIAM and has not selected a valid reason
    Then I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "No"
    Then I should see "Do you have a valid reason for not attending a MIAM?"
    And I wait and click the "Continue" button
    Then I should see "Sorry, you'll have to start again"
    And the time goes back to normal


