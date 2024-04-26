Feature: MIAM journey
  Background:
    Given Mediation changes do not apply
    Given I have started an application
    When I visit "steps/miam/acknowledgement"
    Then I should see "Have you previously been to mediation through the mediation voucher scheme?"
    And I choose "Yes"
    Then I should see "Attending a Mediation Information and Assessment Meeting (MIAM)"
    And I check "I understand that I have to attend a MIAM, or a non-court dispute resolution process, or provide a valid reason for not attending."
    And I click the "Continue" button

  @happy_path
  Scenario: Applicant attended a MIAM
    Then I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "Yes"
    Then I should see "Have you got a document signed by the mediator?"
    And I choose "Yes"
    Then I should see "Upload your MIAM certificate"
    And the mediation changes end

  @unhappy_path
  Scenario: Applicant attended a MIAM but lacks the certificate
    Then I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "Yes"
    Then I should see "Have you got a document signed by the mediator?"
    And I choose "No"
    Then I should see "You need to get a document from the mediator"
    Then I should see "Save and come back later"
    And the mediation changes end

  @unhappy_path
  Scenario Outline: Applicant did not attend a MIAM and does not have a mediator’s exemption
    Then I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "No"
    Then I should see "Do you have a valid reason for not attending a MIAM?"
    And I choose "<has_valid_reason>"
    Then I should see "<outcome_page_header>"
    And the mediation changes end

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
    And the mediation changes end


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
    And I click the "Continue" button

    Then I should see "You don’t have to attend a MIAM"
    Then I should see "Other exemptions"
    Then I should see "You’re applying for a without notice hearing"

    And I click the "Continue" link
    Then I should see "Safety concerns"
    And the mediation changes end

  @happy_path
  Scenario: Test timeout for applicant attended a MIAM
    When I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "Yes"
    Then I should see "Have you got a document signed by the mediator?"
    When I wait and click the "Continue" button
    Then I should see "Sorry, you'll have to start again"
    And the mediation changes end

  @unhappy_path
  Scenario: Test timeout for applicant attended a MIAM but lacks the certificate
    When I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "Yes"
    Then I should see "Have you got a document signed by the mediator?"
    When I wait and click the "Continue" button
    Then I should see "Sorry, you'll have to start again"
    And the mediation changes end

  @unhappy_path
  Scenario: Test timeout for applicant did not attend a MIAM and does not have a mediator’s exemption
    Then I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "No"
    Then I should see "Do you have a valid reason for not attending a MIAM?"
    Then I wait and click the "Continue" button
    And I should see "Sorry, you'll have to start again"
    And the mediation changes end

  @unhappy_path
  Scenario: Test timeout for applicant did not attend a MIAM and has not selected a valid reason
    Then I should see "Have you attended a Mediation Information and Assessment Meeting (MIAM)?"
    And I choose "No"
    Then I should see "Do you have a valid reason for not attending a MIAM?"
    And I wait and click the "Continue" button
    Then I should see "Sorry, you'll have to start again"
    And the mediation changes end


