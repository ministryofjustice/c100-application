Feature: Add an applicant to the application
  Background:
    # We need at least 1 child as a precondition for this journey  
    Given I have started an application
    When I navigate to applicant names page from consent order
    Then I visit "steps/applicant/names"

  @happy_path
  Scenario: Applicant personal details
    Then I should see "Enter your name"
    And I should see "Enter a new name"

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Error: Applicant names - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter the first name" link to "#steps-applicant-names-split-form-new-first-name-field-error"
    And I should see a "Enter the last name" link to "#steps-applicant-names-split-form-new-last-name-field-error"

    When I fill in "First name(s)" with "!@£"
    And I fill in "Last name(s)" with "$%^"
    And I click the "Continue" button
    Then Page has title "Error: Applicant names - Apply to court about child arrangements - GOV.UK"
    And I should see a "Name must not contain special characters" link to "#steps-applicant-names-split-form-new-first-name-field-error"
    And I should see a "Name must not contain special characters" link to "#steps-applicant-names-split-form-new-last-name-field-error"

    # Fix validation errors and continue
    When applicant names page I submit names "John" and "Doe Senior"
    Then I should see "Do the other people named in this application (the respondents) know any of your contact details?"

    # Provoke privacy known validation errors
    When I click the "Continue" button
    Then Page has title "Error: Contact details confidentiality - Apply to court about child arrangements - GOV.UK"
    And I should see a "Select an option" link to "#steps-applicant-privacy-known-form-privacy-known-field-error"

    # Fix privacy known validation errors and continue
    When applicant privacy known page I submit "yes"
    Then I should see "Do you want to keep your contact details private"

    # Provoke privacy preferences validation errors
    When I click the "Continue" button
    Then I should see "Do you want to keep your contact details private"
    Then Page has title "Error: Contact details confidentiality - Apply to court about child arrangements - GOV.UK"
    And I should see a "Select an option" link to "#steps-applicant-privacy-preferences-form-are-contact-details-private-field-error"

    # Fix privacy preferences validation errors and continue
    When applicant privacy preferences page I submit "no"
    Then I should see "Are you currently resident in a refuge?"

    # Provoke refuge validation error
    And I choose "Yes"
    Then Page has title "Error: Are you currently resident in a refuge? - Apply to court about child arrangements - GOV.UK"
    And I should see a "You must keep your current address private from the other people in this application if you are currently resident in a refuge. Select current address on the previous page if you are currently resident in a refuge" link to "#steps-applicant-refuge-form-refuge-field-error"

    # Fix refuge validation error and continue
    When applicant refuge page I submit "no"
    Then I should see "The court will not keep your contact details private"
    When I click the "Continue" link
    Then I should see "Provide details for John Doe Senior"

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Error: Applicant personal details - Apply to court about child arrangements - GOV.UK"
    And I should see a "Select if you’ve changed your name" link to "#steps-applicant-personal-details-form-has-previous-name-field-error"
    And I should see a "Select the sex" link to "#steps-applicant-personal-details-form-gender-field-error"
    And I should see a "Enter the date of birth" link to "#steps-applicant-personal-details-form-dob-field-error"
    And I should see a "Enter your place of birth" link to "#steps-applicant-personal-details-form-birthplace-field-error"

    # Fix validation errors and continue testing date of birth
    When applicant personal details page I submit details with has_previous_name "no", gender "male", day "1", month "1", year "1000", birthplace "Manchester"
    Then Page has title "Error: Applicant personal details - Apply to court about child arrangements - GOV.UK"

    When applicant personal details page I submit details with has_previous_name "no", gender "male", day "1", month "1", year "2050", birthplace "Manchester"
    Then Page has title "Error: Applicant personal details - Apply to court about child arrangements - GOV.UK"

    # For an under 18 applicant
    When applicant personal details page I submit details with has_previous_name "no", gender "male", day "25", month "05", year "2020", birthplace "Manchester"
    Then I should see "As the applicant is under 18"

    # Get back
    And I click the "Back" link

    # For an over 18 applicant
    When applicant personal details page I submit details with has_previous_name "no", gender "male", day "25", month "05", year "1998", birthplace "Manchester"
    Then I should see "What is John Doe Senior's relationship to John Doe Junior?"

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Error: Applicant relationship - Apply to court about child arrangements - GOV.UK"
    And I should see a "Select the relationship" link to "#steps-shared-relationship-form-relation-field-error"

    # Fix validation errors and continue
    When applicant relationship page I submit "Father"
    Then I should see "Address of John Doe Senior"

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Error: Address lookup - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter the postcode" link to "#steps-address-lookup-form-postcode-field-error"

    # Fix validation errors and continue (do not use lookup API)
    When address lookup page I click outside uk
    And I should see "Address details of John Doe Senior"

    # Provoke validation errors
    When applicant address details page I continue without filling
    Then Page has title "Error: Applicant address details - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter the first line of the address" link to "#steps-applicant-address-details-form-address-line-1-field-error"
    And I should see a "Enter the town or city" link to "#steps-applicant-address-details-form-town-field-error"
    And I should see a "Enter the country" link to "#steps-applicant-address-details-form-country-field-error"
    And I should see a "Select yes if you’ve lived at the address for more than 5 years" link to "#steps-applicant-address-details-form-residence-requirement-met-field-error"

    # Fix validation errors and continue
    When applicant address details page I submit address with address_line_1 "Test street", town "London", country "United Kingdom", residence_5_years "yes"
    Then I should see "Contact details of John Doe Senior"

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Error: Applicant contact details - Apply to court about child arrangements - GOV.UK"
    And I should see a "Select an option" link to "#steps-applicant-contact-details-form-email-provided-field-error"
    And I should see a "Enter a phone number or tell us why the court cannot phone you" link to "#steps-applicant-contact-details-form-phone-number-provided-field-error"

    When I click the radio button "I can provide an email address"
    And I click the radio button "I can provide a phone number"
    And I fill in "Your email address" with "01234567890"
    And I fill in "Your phone number" with "abcdefghijklmnopqrstuvwxyz"
    And I click the radio button "Yes, the court can leave me a voicemail"
    And I click the "Continue" button
    Then Page has title "Error: Applicant contact details - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter an email address in the correct format, like name@example.com" link to "#steps-applicant-contact-details-form-email-field-error"
    And I should see a "Enter a phone number in the correct format, like 07700 900 982" link to "#steps-applicant-contact-details-form-phone-number-field-error"

   # Fix validation errors and continue
    When applicant contact details page I submit contact with email "john@email.com", phone "00000000000", voicemail_consent "yes"
    Then I should see "Will you be legally represented by a solicitor in these proceedings?"
    When applicant has solicitor page I submit "no"

    # Finalise here as we start the respondent journey in respondent_details.feature
    Then I should see "Enter the respondent’s name"

  @happy_path
  Scenario: Solicitor representative details journey
    When I visit "steps/solicitor/personal_details"
    Then I should see "Details of solicitor"

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Error: Details of solicitor - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter the full name" link to "#steps-solicitor-personal-details-form-full-name-field-error"
    And I should see a "Enter the name of the firm" link to "#steps-solicitor-personal-details-form-firm-name-field-error"

    When I fill in "Full name" with "¡€#"
    And I fill in "Name of firm" with "#¢∞"
    And I click the "Continue" button
    Then I should see a "Name must not contain special characters" link to "#steps-solicitor-personal-details-form-full-name-field-error"

   # Fix validation errors and continue
    When solicitor personal details page I submit details with full_name "Dwayne Solicitor", firm_name "Dwayne Firm"
    Then I should see "Address details of Dwayne"
    And Page has title "Address details of solicitor - Apply to court about child arrangements - GOV.UK"

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Error: Address details of solicitor - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter the first line of the address" link to "#steps-solicitor-address-details-form-address-line-1-field-error"
    And I should see a "Enter the town or city" link to "#steps-solicitor-address-details-form-town-field-error"
    And I should see a "Enter the country" link to "#steps-solicitor-address-details-form-country-field-error"
    And I should see a "Enter the postcode" link to "#steps-solicitor-address-details-form-postcode-field-error"

    When I fill in "Building and street" with "#¢∞"
    And I fill in "Town or city" with "#¢∞"
    And I fill in "Country" with "#¢∞"
    And I fill in "Postcode" with "#¢∞"
    And I click the "Continue" button
    Then I should see a "is invalid" link to "#steps-solicitor-address-details-form-postcode-field-error"

    # Fix validation errors and continue
    When solicitor address details page I submit address with address_line_1 "Street A", town "London", country "United Kingdom", postcode "SW1A 1AA"
    Then I should see "Contact details of Dwayne Solicitor"
    And Page has title "Contact details of solicitor - Apply to court about child arrangements - GOV.UK"

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Contact details of solicitor - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter an email address" link to "#steps-solicitor-contact-details-form-email-field-error"
    And I should see a "Enter a phone number in the correct format, like 07700 900 982" link to "#steps-solicitor-contact-details-form-phone-number-field-error"

    When I fill in "Email address" with "¡€#"
    And I fill in "Phone number" with "¡€#"
    And I fill in "DX number" with "¡€#"
    And I click the "Continue" button
    Then Page has title "Error: Contact details of solicitor - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter an email address in the correct format, like name@example.com" link to "#steps-solicitor-contact-details-form-email-field-error"
    And I should see a "Enter a phone number in the correct format, like 07700 900 982" link to "#steps-solicitor-contact-details-form-phone-number-field-error"
    And I should see a "Enter a valid DX number" link to "#steps-solicitor-contact-details-form-dx-number-field-error"

    # Fix validation errors and continue
    When solicitor contact details page I submit contact with email "dwayne@email.com", phone "00000000000", dx_number "123-456"
    Then Page has title "Respondent names - Apply to court about child arrangements - GOV.UK"

    When I visit "steps/applicant/has_solicitor"
    And Page has title "Do you have a solicitor? - Apply to court about child arrangements - GOV.UK"
    When applicant has solicitor page I submit "no"
    Then Page has title "Respondent names - Apply to court about child arrangements - GOV.UK"

  @happy_path
  Scenario: Test timeout on applicant personal details
    When I should see "Enter your name"
    And I should see "Enter a new name"
    And I wait and click the "Continue" button
    Then I should see "Sorry, you'll have to start again"

  @happy_path
  Scenario: Test timeout on solicitor representative details journey
    When I visit "steps/solicitor/personal_details"
    And I should see "Details of solicitor"
    And I wait and click the "Continue" button
    Then I should see "Sorry, you'll have to start again"