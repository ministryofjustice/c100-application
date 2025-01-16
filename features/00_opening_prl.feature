Feature: Opening PRL

  Background: Navigating to the start page
    Given Opening changes apply
    When I visit "/"
    Then I should see "Start or continue an application"
    And I should see a "Back" link to "https://www.gov.uk/looking-after-children-divorce/apply-for-court-order"

  Scenario: Complete the opening
    When I click the radio button "Start a new application"
    When I fill in "Enter the children's postcode" with "MK9 3DX"
    And I click the "Continue" button
    Then I should see "What you’ll need to complete your application"
    And I click the "Continue" link
    Then I should see "What kind of application do you want to make?"
    And I should not see the save draft button
    And the opening changes end

  @happy_path
  Scenario: Testing application timeout (Should not trigger here)
    When I click the radio button "Start a new application"
    When I fill in "Enter the children's postcode" with "MK9 3DX"
    And I click the "Continue" button

    Then I should see "What you’ll need to complete your application"
    And I click the "Continue" link

    Then I should see "What kind of application do you want to make?"
    And I should not see the save draft button
    And I choose "Child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order"
    Then I should see "Does this application concern a child who is the subject of separate ongoing emergency proceedings, care proceedings or supervision proceedings (or is already the subject of an emergency, care or supervision order)?"
    And I should not see the save draft button
    And I choose "No"
    Then I should see "Attending a Mediation Information and Assessment Meeting (MIAM)"
    And I should see the save draft button
    And the opening changes end

  Scenario: Research question with alternate application page layout
    When I click the radio button "Start a new application"
    When I fill in "Enter the children's postcode" with "MK9 3DX"
    And I click the "Continue" button
    And the opening changes end

  @happy_path
  Scenario: Testing the back button
    When I click the "Back" link
    Then I should see "Making child arrangements if you divorce or separate"
    And the opening changes end

  @happy_path
  Scenario: Checking the dropdown
    When I open the "If you do not know where the children live, or they live at different addresses" summary details
    Then I should see "If you do not know where the children live, enter your own postcode."
    And the opening changes end

  @happy_path
  Scenario: Postcode entry without a space
    When I click the radio button "Start a new application"
    When I fill in "Enter the children's postcode" with "MK93DX"
    And I click the "Continue" button
    Then I should see "What you’ll need to complete your application"
    And the opening changes end

  Scenario: I don't fill out the postcode
    When I click the radio button "Start a new application"
    And I click the "Continue" button

    Then I should be on "/steps/opening/start_or_continue"
    And Page has title "Error: Start or continue an application - Apply to court about child arrangements - GOV.UK"
    And I should see "There is a problem on this page" in the error summary
    And I should see a "Enter a full postcode, with or without a space" link to "#steps-opening-start-or-continue-form-children-postcode-field-error"

    Then I click the "Enter a full postcode, with or without a space" link
    And I should see "Enter a full postcode, with or without a space" error in the form
    And "steps-opening-start-or-continue-form-children-postcode-field-error" has focus
    And the opening changes end

  @unhappy_path
  Scenario: Postcode not eligible
    When I click the radio button "Start a new application"
    When I fill in "Enter the children's postcode" with "TQ12 1FF"
    And I click the postcode page "Continue" button with an invalid postcode
    Then I should see "Sorry, you cannot apply online"
    And I should see a "Download the form (PDF)" link to "https://formfinder.hmctsformfinder.justice.gov.uk/c100-eng.pdf"
    And the opening changes end

  @unhappy_path
  Scenario: Postcode not eligible (alternate page layout)
    When I click the radio button "Start a new application"
    When I fill in "Enter the children's postcode" with "TQ12 1FF"
    And I click the postcode page "Continue" button with an invalid postcode

    Then I should see "Sorry, you cannot apply online"
    And I should see a "Download the form (PDF)" link to "https://formfinder.hmctsformfinder.justice.gov.uk/c100-eng.pdf"
    And the opening changes end

  @unhappy_path
  Scenario: Postcode not recognised (alternate page layout)
    Given I stub fact api call
    When I click the radio button "Start a new application"
    When I fill in "Enter the children's postcode" with "TQ121XX"
    And I click the "Continue" button

    Then I should see "Something went wrong"
    And I should see a "Download the form (PDF)" link to "https://formfinder.hmctsformfinder.justice.gov.uk/c100-eng.pdf"
    And I should see a "Go back and try again" link to "/steps/opening/start_or_continue"
    And the opening changes end
