Feature: Opening

  Background: Navigating to the start page
    Given Opening changes do not apply
    When I visit "/"
    Then Page has title "What is required - Apply to court about child arrangements - GOV.UK"
    And I should see a "Back" link to "https://www.gov.uk/looking-after-children-divorce/apply-for-court-order"

  @alternate_layout
  Scenario: Complete the opening (alternate page layout)
    Then I should see "Start or continue an application"
    Then Page has title "What is required - Apply to court about child arrangements - GOV.UK"
    And I should see a "Back" link to "https://www.gov.uk/looking-after-children-divorce/apply-for-court-order"
    When I click the radio button "Start a new application"
    When I fill in "Enter the children's postcode" with "MK9 3DX"
    And I click the "Continue" button
    Then I should see "What you’ll need to complete your application"
    And I should see a "Back" link to "/"
    And I should see a "Or return to a saved application" link to "/users/login"
    When I click the "Continue" link
    Then I should see "What kind of application do you want to make?"
    And the opening changes end

  @alternate_layout @happy_path
  Scenario: Complete the opening (alternate page layout)
    When I click the radio button "Start a new application"
    When I fill in "Enter the children's postcode" with "MK9 3DX"
    And I click the "Continue" button

    Then I should see "Are you willing to be contacted to share your experience of using this service?"
    And I should not see the save draft button
    And I choose "No"

    Then I should see "Citizen or solicitor applying on behalf of a citizen?"
    And I choose "I am applying as a citizen"
    And I click the "Continue" button
    And the opening changes end

  Scenario: Complete the opening
    When I should see "What you’ll need to complete your application"
    And I click the "Continue" link

    Then I should see "Where do the children live?"
    And Page has title "Where the children live - Apply to court about child arrangements - GOV.UK"
    And I fill in "Postcode" with "SW1A 1AA"
    And I click the "Continue" button

    Then I should see "What kind of application do you want to make?"
    And I should not see the save draft button
    And I choose "Child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order"
    Then I should see "Does this application concern a child who is the subject of separate ongoing emergency proceedings, care proceedings or supervision proceedings (or is already the subject of an emergency, care or supervision order)?"
    And I should not see the save draft button
    And I choose "No"
    Then I should see "Attending a Mediation Information and Assessment Meeting (MIAM)"
    And I should see the save draft button
    And the opening changes end

  @happy_path
  Scenario: Testing application timeout (Should not trigger here)
    When I should see "What you’ll need to complete your application"
    And I wait and click the "Continue" button
    Then I should see "Where do the children live?"
    And Page has title "Where the children live - Apply to court about child arrangements - GOV.UK"
    And I fill in "Postcode" with "SW1A 1AA"
    And I click the "Continue" button

    Then I should see "What kind of application do you want to make?"
    And I should not see the save draft button
    And I choose "Child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order"
    Then I should see "Does this application concern a child who is the subject of separate ongoing emergency proceedings, care proceedings or supervision proceedings (or is already the subject of an emergency, care or supervision order)?"
    And I should not see the save draft button
    And I choose "No"
    Then I should see "Attending a Mediation Information and Assessment Meeting (MIAM)"
    And I should see the save draft button
    And the opening changes end
    And the time goes back to normal

  @alternate_layout
  Scenario: Research question with alternate application page layout
    When I click the radio button "Start a new application"
    When I fill in "Enter the children's postcode" with "MK9 3DX"
    And I click the "Continue" button
    Then I should see "Are you willing to be contacted to share your experience of using this service?"
    And I should not see the save draft button
    And I choose "No"
    And the opening changes end

  @happy_path
  Scenario: Testing the back button
    When I click the "Back" link
    Then I should see "Making child arrangements if you divorce or separate"
    And the opening changes end

  @happy_path
  Scenario: Checking the dropdown
    When I should see "What you’ll need to complete your application"
    And I click the "Continue" link
    Then I should see "Where do the children live?"
    And I open the "If you do not know where the children live" summary details
    And I should see "If you do not know the children’s postcode please enter your own."
    And the opening changes end

  @happy_path
  Scenario: Postcode entry without a space
    When I should see "What you’ll need to complete your application"
    And I click the "Continue" link
    Then I should see "Where do the children live?"
    When I fill in "Postcode" with "MK93DX"
    And I click the "Continue" button
    Then I should see "What kind of application do you want to make?"
    And the opening changes end

  Scenario: I don't fill out the postcode
    When I should see "What you’ll need to complete your application"
    And I click the "Continue" link
    Then I should see "Where do the children live?"

    When I click the "Continue" button
    Then Page has title "Where the children live - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter a full postcode, with or without a space" link to "#steps-opening-postcode-form-children-postcode-field-error"
    And the opening changes end

  @unhappy_path
  Scenario: Postcode not eligible
    When I should see "What you’ll need to complete your application"
    And I click the "Continue" link
    Then I should see "Where do the children live?"

    When I fill in "Postcode" with "TQ12 1FF"
    And court finder raises an error
    And I click the "Continue" button
    Then Page has title "Where the children live - Apply to court about child arrangements - GOV.UK"
    And I should see "Something went wrong"
    And I should see a "Download the form (PDF)" link to "https://formfinder.hmctsformfinder.justice.gov.uk/c100-eng.pdf"
    And the opening changes end

  @alternate_layout @unhappy_path
  Scenario: Postcode not eligible (alternate page layout)
    When I click the radio button "Start a new application"
    When I fill in "Enter the children's postcode" with "TQ12 1FF"
    And I click the postcode page "Continue" button with an invalid postcode

    Then I should see "Sorry, you cannot apply online"
    And I should see a "Download the form (PDF)" link to "https://formfinder.hmctsformfinder.justice.gov.uk/c100-eng.pdf"
    And the opening changes end

  @alternate_layout @unhappy_path
  Scenario: Postcode not recognised (alternate page layout)
    Given I stub fact api call
    When I fill in "Postcode" with "TQ121XX"
    And I click the "Continue" button

    Then I should see "Something went wrong"
    And I should see a "Download the form (PDF)" link to "https://formfinder.hmctsformfinder.justice.gov.uk/c100-eng.pdf"
    And I should see a "Go back and try again" link to "/steps/opening/postcode"
    And the opening changes end
