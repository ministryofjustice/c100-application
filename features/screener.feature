Feature: Screener
  Background:
    When I visit "/"
    Then I should see "Use this service to make an application for child arrangements in England or Wales"
    And  I click the "Check eligibility" link
    Then I should see "Where do the children live?"

  @happy_path
  Scenario: Complete the screener
    When I fill in "Postcode" with "MK9 3DX"
    And I click the "Continue" button

    Then I should see "You’re eligible to apply online"

    And I click the "Continue" link
    Then I should see "The court fee is £215"
    Then I should see "Before you start your application"

    And I click the "Start application" link
    Then I should see "What you’ll need to complete your application"

    # Finish here as we already have other scenarios testing the journey from this point onwards
    And I click the "Continue" link
    Then I should see "How long it takes to apply"

  @unhappy_path
  Scenario: I don't fill out the postcode
    When I click the "Continue" button

    Then I should be on "/steps/screener/postcode"
    And Page has title "Error: Where the children live - Apply to court about child arrangements - GOV.UK"
    And I should see "There is a problem on this page" in the error summary
    And I should see a "Enter a full postcode, with or without a space" link to "#steps-screener-postcode-form-children-postcodes-field-error"

    Then I click the "Enter a full postcode, with or without a space" link
    And I should see "Enter a full postcode, with or without a space" error in the form
    And "steps-screener-postcode-form-children-postcodes-field-error" has focus

  @unhappy_path
  Scenario: Postcode not eligible
    When I fill in "Postcode" with "ZE2 9TE"
    And I click the "Continue" button

    Then I should see "Sorry, you cannot apply online"
    And I should see a "Download the form (PDF)" link to "https://formfinder.hmctsformfinder.justice.gov.uk/c100-eng.pdf"

  @unhappy_path
  Scenario: Postcode not recognised
    When I fill in "Postcode" with "GU2 9JE"
    And I click the "Continue" button

    Then I should see "Something went wrong"
    And I should see a "Download the form (PDF)" link to "https://formfinder.hmctsformfinder.justice.gov.uk/c100-eng.pdf"
    And I should see a "Go back and try again" link to "/steps/screener/postcode"
