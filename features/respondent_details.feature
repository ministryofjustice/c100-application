Feature: Add a respondent to the application
  Background:
    # We need at least 1 child as a precondition for this journey
    Given Privacy changes apply
    Given I have started an application
    And I have entered a child with first name "John" and last name "Doe Junior"
    Then I visit "steps/respondent/names"

  @happy_path @skip
  Scenario: Respondent personal details
    Then I should see "Enter the respondent’s name"
    And I should see "Enter a new name"

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Error: Respondent names - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter the first name" link to "#steps-respondent-names-split-form-new-first-name-field-error"
    And I should see a "Enter the last name" link to "#steps-respondent-names-split-form-new-last-name-field-error"

    When I fill in "First name(s)" with "¡€#"
    And I fill in "Last name(s)" with "¢∞§"
    And I click the "Continue" button
    Then Page has title "Error: Respondent names - Apply to court about child arrangements - GOV.UK"
    And I should see a "Name must not contain special characters" link to "#steps-respondent-names-split-form-new-first-name-field-error"
    And I should see a "Name must not contain special characters" link to "#steps-respondent-names-split-form-new-last-name-field-error"

    # Fix validation errors and continue
    Then I fill in "First name(s)" with "Olivia"
    And I fill in "Last name(s)" with "Doe Senior"
    When I click the "Continue" button
    Then I should see "Provide details for Olivia Doe Senior"

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Error: Respondent personal details - Apply to court about child arrangements - GOV.UK"
    And I should see a "Select if they’ve changed their name" link to "#steps-respondent-personal-details-form-has-previous-name-field-error"
    And I should see a "Select the sex" link to "#steps-respondent-personal-details-form-gender-field-error"
    And I should see a "Enter the date of birth" link to "#steps-respondent-personal-details-form-dob-field-error"

    When I click "Don't know" for the radio button "Have they changed their name?"
    And I choose "Female"
    And I enter the date 1-1-100
    And I fill in "Place of birth" with "¡€#"
    And I click the "Continue" button
    Then Page has title "Error: Respondent personal details - Apply to court about child arrangements - GOV.UK"
    And I should see a "Date of birth is not valid" link to "#steps-respondent-personal-details-form-dob-field-error"

    When I enter the date 25-05-2070
    And I click the "Continue" button
    Then Page has title "Error: Respondent personal details - Apply to court about child arrangements - GOV.UK"
    And I should see a "Date of birth must be in the past" link to "#steps-respondent-personal-details-form-dob-field-error"

    # Fix validation errors and continue
    When I enter the date 25-05-2012
    And I fill in "Place of birth" with "London"
    When I click the "Continue" button
    Then I should see "What is Olivia Doe Senior's relationship to John Doe Junior?"

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Error: Respondent relationship - Apply to court about child arrangements - GOV.UK"
    And I should see a "Select the relationship" link to "#steps-shared-relationship-form-relation-field-error"

    When I choose "Other"
    And I click the "Continue" button
    Then Page has title "Error: Respondent relationship - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter the relationship" link to "#steps-shared-relationship-form-relation-other-value-field-error"

    # Fix validation errors and continue
    Then I choose "Mother"
    When I click the "Continue" button
    Then I should see "Address of Olivia Doe Senior"

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Error: Address lookup - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter the postcode" link to "#steps-address-lookup-form-postcode-field-error"

    When I fill in "Current postcode" with "12345"
    And I click the "Continue" button
    Then Page has title "Error: Address lookup - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter a valid postcode" link to "#steps-address-lookup-form-postcode-field-error"

    When I fill in "Current postcode" with "¡€#"
    And I click the "Continue" button
    Then Page has title "Error: Address lookup - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter a valid postcode" link to "#steps-address-lookup-form-postcode-field-error"

    # Fix validation errors and continue (do not use lookup API)
    When I click the "I don’t know their postcode or they live outside the UK" link
    And I should see "Address details of Olivia Doe Senior"

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Error: Respondent address details - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter the first line of the address or select if you don’t know where they live" link to "#steps-respondent-address-details-form-address-line-1-field-error"
    And I should see a "Enter the town or city or select if you don’t know where they live" link to "#steps-respondent-address-details-form-town-field-error"
    And I should see a "Select yes if they’ve lived at the address for more than 5 years" link to "#steps-respondent-address-details-form-residence-requirement-met-field-error"

    When I fill in "Building and street" with "¡€#"
    And I fill in "Town or city" with "¡€#"
    And I fill in "Postcode" with "¡€#"
    And I click the "Continue" button
    Then Page has title "Error: Respondent address details - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter a valid full postcode, with or without a space" link to "#steps-respondent-address-details-form-postcode-field-error"
    And I should see a "Select yes if they’ve lived at the address for more than 5 years" link to "#steps-respondent-address-details-form-residence-requirement-met-field-error"

    # Fix validation errors and continue
    When I fill in "Building and street" with "Test street"
    And I fill in "Town or city" with "London"
    And I fill in "Postcode" with ""
    And I fill in "Country" with "United Kingdom"
    And I click "Don't know" for the radio button "Have they lived at this address for more than 5 years?"
    When I click the "Continue" button

    # Provoke validation errors on contact details page
    When I click the "Continue" button
    Then Page has title "Error: Respondent contact details - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter an email address in the correct format, like name@example.com" link to "#steps-respondent-contact-details-form-email-field-error"
    And I should see a "Enter an answer" link to "#steps-respondent-contact-details-form-phone-number-field-error"

    When I fill in "Email address" with "¡€#"
    And I fill in "Phone number" with "¢∞§"
    And I click the "Continue" button
    Then Page has title "Error: Respondent contact details - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter an email address in the correct format, like name@example.com" link to "#steps-respondent-contact-details-form-email-field-error"
    And I should see a "Enter a phone number in the correct format, like 07700 900 982" link to "#steps-respondent-contact-details-form-phone-number-field-error"

    When I check "I don't know their email"
    And I fill in "Email address" with "test@example.com"
    And I check "I don't know their phone number"
    And I fill in "Phone number" with "07777777777"
    And I click the "Continue" button
    Then Page has title "Error: Respondent contact details - Apply to court about child arrangements - GOV.UK"
    And I should see a "Cannot select 'I don't know their email' and input 'Email address'" link to "#steps-respondent-contact-details-form-email-field-error"
    And I should see a "Cannot select 'I don't know their phone number' and input 'Phone number'" link to "#steps-respondent-contact-details-form-phone-number-field-error"

    # Fix validation errors and continue
    When I click the "Back" link
    And I should see "Address details of Olivia Doe Senior"
    And I click the "Continue" button
    And I fill in "Email address" with "test@example.com"
    And I fill in "Phone number" with "07777777777"

    When I click the "Continue" button
    Then I should see "Is there anyone else who should know about your application?"
    Then I choose "No"
    Then I should see "Who does John Doe Junior currently live with?"

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Error: Child residence - Apply to court about child arrangements - GOV.UK"
    And I should see a "You must select at least one person" link to "#steps-children-residence-form-person-ids-field-error"

    # Fix validation errors and continue
    Then I check "Olivia Doe Senior"
    When I click the "Continue" button

    # Finalise here as we exit the `people` journeys
    Then I should see "Have any of the children in this application been involved in other family court proceedings?"

  @happy_path @skip
  Scenario: Testing addition of exterior person to application
    When I visit "/steps/respondent/has_other_parties"
    And I should see "Is there anyone else who should know about your application?"
    And I choose "Yes"
    Then I should see "Enter the other person’s name"

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Error: Other people - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter the first name" link to "#steps-other-party-names-split-form-new-first-name-field-error"
    And I should see a "Enter the last name" link to "#steps-other-party-names-split-form-new-last-name-field-error"

    When I fill in "First name(s)" with "¡€#"
    And I fill in "Last name(s)" with "¢∞§"
    And I click the "Continue" button
    Then I should see a "Name must not contain special characters" link to "#steps-other-party-names-split-form-new-first-name-field-error"
    Then I should see a "Name must not contain special characters" link to "#steps-other-party-names-split-form-new-last-name-field-error"

    # Fixing validation errors and continuing
    When I fill in "First name(s)" with "Thomas"
    And I fill in "Last name(s)" with "Other Doe"
    And I click the "Continue" button
    Then Page has title "Do any of the children live with Thomas Other Doe? - Apply to court about child arrangements - GOV.UK"
    And I should see "Do any of the children live with Thomas Other Doe?"

    # Provoke validation errors
    And I click the "Continue" button
    Then Page has title "Error: Do any of the children live with Thomas Other Doe? - Apply to court about child arrangements - GOV.UK"
    And I should see a "Select an option" link to "#steps-other-party-children-cohabit-other-form-cohabit-with-other-field-error"

    # Fix validation errors and continue
    And I choose "Yes"
    And I should see "Keeping Thomas Other Doe's details private"

    # Provoke validation errors
    And I click the "Continue" button
    Then Page has title "Error: Contact details confidentiality - Apply to court about child arrangements - GOV.UK"
    And I should see a "Select an option" link to "#steps-other-party-privacy-preferences-form-are-contact-details-private-field-error"

    # Fix validation errors and continue
    And I choose "No"
    And I click the "Continue" button
    Then Page has title "Other person personal details - Apply to court about child arrangements - GOV.UK"
    And I should see "Provide details for Thomas Other Doe"

    # Go back and provoke Refuge page from yes
    When I click the "Back" link
    And I should see "Keeping Thomas Other Doe's details private"
    And I choose "Yes"
    And I click the "Continue" button
    And I should see "Is Thomas Other Doe currently resident in a refuge?"

    And I click the "Continue" button
    Then Page has title "Error: Is currently resident in a refuge? - Apply to court about child arrangements - GOV.UK"
    And I should see a "Select yes if the other party is currently resident in a refuge" link to "#steps-other-party-refuge-form-refuge-field-error"

    And I choose "No"
    And I click the "Continue" button

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Error: Other person personal details - Apply to court about child arrangements - GOV.UK"
    And I should see a "Select if they’ve changed their name" link to "#steps-other-party-personal-details-form-has-previous-name-field-error"
    And I should see a "Select the sex" link to "#steps-other-party-personal-details-form-gender-field-error"
    And I should see a "Enter the date of birth" link to "#steps-other-party-personal-details-form-dob-field-error"

    When I click "Don't know" for the radio button "Have they changed their name?"
    And I choose "Female"
    And I enter the date 1-1-100
    And I click the "Continue" button
    Then Page has title "Error: Other person personal details - Apply to court about child arrangements - GOV.UK"
    And I should see a "Date of birth is not valid" link to "#steps-other-party-personal-details-form-dob-field-error"

    When I enter the date 20-10-2070
    And I click the "Continue" button
    Then Page has title "Error: Other person personal details - Apply to court about child arrangements - GOV.UK"
    And I should see a "Date of birth must be in the past" link to "#steps-other-party-personal-details-form-dob-field-error"

    # Fix validation errors and continue
    When I enter the date 20-01-1979
    And I click the "Continue" button
    Then Page has title "Other person relationship - Apply to court about child arrangements - GOV.UK"
    And I should see "What is Thomas Other Doe's relationship to John Doe Junior?"

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Error: Other person relationship - Apply to court about child arrangements - GOV.UK"
    And I should see a "Select the relationship" link to "#steps-shared-relationship-form-relation-field-error"

    When I choose "Other"
    Then Page has title "Error: Other person relationship - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter the relationship" link to "#steps-shared-relationship-form-relation-other-value-field-error"

    # Fix validation errors and continue
    When I choose "Grandparent"
    And I should see "Address of Thomas Other Doe"

    # Provoke validation errors
    When I fill in "Current postcode" with "¡€#§¶•"
    And I click the "Continue" button
    Then Page has title "Error: Address lookup - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter a valid postcode" link to "#steps-address-lookup-form-postcode-field-error"

    # Fix this validation error and continue to different address input page
    When I click the "I don’t know their postcode or they live outside the UK" link
    And Page has title "Other person Address details - Apply to court about child arrangements - GOV.UK"
    And I should see "Address details of Thomas Other Doe"

    # Provoke validation errors
    When I click the "Continue" button
    Then Page has title "Error: Other person Address details - Apply to court about child arrangements - GOV.UK"
    And I should see a "Enter the first line of the address or select if you don’t know where they live" link to "#steps-other-party-address-details-form-address-line-1-field-error"
    And I should see a "Enter the town or city or select if you don’t know where they live" link to "#steps-other-party-address-details-form-town-field-error"

    # (Fix validation errors) and continue
    When I fill in "Building and street" with "Test street"
    And I fill in "Town or city" with "London"
    And I fill in "Country" with "United Kingdom"
    And I click the "Continue" button
    Then Page has title "Child residence - Apply to court about child arrangements - GOV.UK"

    # Provoke validation error
    When I click the "Continue" button
    Then Page has title "Error: Child residence - Apply to court about child arrangements - GOV.UK"

    # Fix validation error and finish section
    When I choose "Thomas Other Doe"
    And I click the "Continue" button
    Then Page has title "Previous proceedings - Apply to court about child arrangements - GOV.UK"

    When I visit "/steps/respondent/has_other_parties"
    And I should see "Is there anyone else who should know about your application?"
    And I choose "Yes"
    Then I should see "Enter the other person’s name"

    And I click the "Continue" button
    Then Page has title "Do any of the children live with Thomas Other Doe? - Apply to court about child arrangements - GOV.UK"
    And I should see "Do any of the children live with Thomas Other Doe?"

    And I choose "No"
    Then Page has title "Other person personal details - Apply to court about child arrangements - GOV.UK"
    And I should see "Provide details for Thomas Other Doe"

    And I click the "Continue" button
    Then Page has title "Other person relationship - Apply to court about child arrangements - GOV.UK"
    And I should see "What is Thomas Other Doe's relationship to John Doe Junior?"

    When I choose "Grandparent"

    And I should see "Address details of Thomas Other Doe"

    When I visit "/steps/respondent/has_other_parties"
    And I should see "Is there anyone else who should know about your application?"
    And I choose "No"
    Then I should see "Who does John Doe Junior currently live with?"

  @happy_path
  Scenario: Test timeout on respondent details page
    When I should see "Enter the respondent’s name"
    And I should see "Enter a new name"
    And I wait and click the "Continue" button
    Then I should see "Sorry, you'll have to start again"
    And the time goes back to normal

  @happy_path
  Scenario: Testing timeout on addition of exterior person to application
    When I visit "/steps/respondent/has_other_parties"
    And I should see "Is there anyone else who should know about your application?"
    And I choose "Yes"
    Then I should see "Enter the other person’s name"
    Then I wait and click the "Continue" button
    And I should see "Sorry, you'll have to start again"
    And the time goes back to normal