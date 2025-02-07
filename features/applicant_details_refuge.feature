Feature: Add an applicant to the application
  Background:
    # We need at least 1 child as a precondition for this journey
    Given Confidential changes do apply
    Given I have started an application
    And I submitted a name for children names
    Then I visit "steps/applicant/names"

  @happy_path
  Scenario: Applicant personal details
    Then I should see the applicant names page

    # Provoke validation errors
    When I click the "Continue" button
    Then Page shows empty applicant names error

    When I enter invalid applicant name
    And I click the "Continue" button
    Then Page shows special character applicant names error

    # Fix validation errors and continue
    Then I enter valid applicant name
    When I click the "Continue" button
    Then I should see the applicant privacy known page

    # Provoke privacy known validation errors
    When I click the "Continue" button
    Then Page shows applicant privacy known errors

    # Fix privacy known validation errors and continue
    And I select "Yes" for applicant privacy known options
    Then I should see the applicant privacy preferences page

    # Provoke privacy preferences validation errors
    When I click the "Continue" button
    Then I should see the applicant privacy preferences page
    Then Page shows applicant privacy preferences errors

    # Fix privacy preferences validation errors and continue
    When I select "No" for applicant privacy preferences
    Then I should see the applicant refuge page

    # Provoke refuge validation error
    And I select "Yes" for applicant refuge options
    Then Page shows applicant refuge errors

    # Fix refuge validation error and continue
    And I select "No" for applicant refuge options
    Then I should see a not private privacy summary for applicant
    And I click the "Continue" button
    Then I should see the applicant personal details page

    # Provoke validation errors
    When I click the "Continue" button
    Then Page shows applicant personal details errors

    # Fix validation errors and continue testing date of birth
    Then I select "No", "Male" for applicant personal details
    And I fill in "Your place of birth" with "Manchester"

    When I enter the date 1-1-1000
    And I click the "Continue" button
    Then Page shows applicant personal details date error

    When I enter the date 1-1-2050
    And I click the "Continue" button
    Then Page shows applicant personal details date past error

    # For an under 18 applicant
    Then I enter the date 25-05-2020
    When I click the "Continue" button
    Then I should see the under age page

    # Get back
    And I click the "Back" link

    # For an over 18 applicant
    Then I enter the date 25-05-1998
    When I click the "Continue" button
    Then I should see the applicant relationship page

    # Provoke validation errors
    When I click the "Continue" button
    Then Page shows applicant relationship errors

    # Fix validation errors and continue
    Then I choose applicant relationship to be "Father"
    Then I should see the applicant address lookup page

    # Provoke validation errors
    When I click the "Continue" button
    Then Page shows address lookup errors

    # Fix validation errors and continue (do not use lookup API)
    When I click the "I live outside the UK" link
    And I should see the applicant address details page

    # Provoke validation errors
    When I click the "Continue" button
    Then Page shows applicant address details errors

    # Fix validation errors and continue
    When I fill in "Building and street" with "Test street"
    And I fill in "Town or city" with "London"
    And I fill in "Country" with "United Kingdom"
    And I click "Yes" for the radio button "Have you lived at your current address for more than 5 years?"
    When I click the "Continue" button
    Then I should see the applicant contact details page

    # Provoke validation errors
    When I click the "Continue" button
    Then Page shows applicant contact details errors

    When I choose "I can provide an email address"
    And I choose "I can provide a mobile phone number"
    And I fill in "Your email address" with "01234567890"
    And I fill in "Your home phone" with "abcdefghijklmnopqrstuvwxyz"
    And I fill in "Your mobile phone" with "abcdefghijklmnopqrstuvwxyz"
    And I choose "Yes, the court can leave me a voicemail"
    Then Page shows applicant contact details errors for format

   # Fix validation errors and continue
    When I fill in "Your email address" with "john@email.com"
    And I fill in "Your home phone" with "00000000000"
    And I fill in "Your mobile phone" with "00000000000"
    And I choose "Yes, the court can leave me a voicemail"
    And I click the "Continue" button
    Then I should see the has solicitor page
    And I choose "No"

    # Finalise here as we start the respondent journey in respondent_details.feature
    Then I should see the respondent names page
    And the confidential changes end

  @happy_path
  Scenario: Solicitor representative details journey
    When I visit "steps/solicitor/personal_details"
    Then I should see the solicitor personal details page

    # Provoke validation errors
    When I click the "Continue" button
    Then Page shows solicitor personal details errors

    When I fill in "Full name" with "¡€#"
    And I fill in "Name of firm" with "#¢∞"
    And I click the "Continue" button
    Then Page shows solicitor personal details error for special characters

   # Fix validation errors and continue
    When I fill in "Full name" with "Dwayne Solicitor"
    And I fill in "Name of firm" with "Dwayne Firm"
    And I click the "Continue" button
    Then I should see the solicitor address details page

    # Provoke validation errors
    When I click the "Continue" button
    Then Page shows solicitor address details errors

    When I fill in "Building and street" with "#¢∞"
    And I fill in "Town or city" with "#¢∞"
    And I fill in "Country" with "#¢∞"
    And I fill in "Postcode" with "#¢∞"
    And I click the "Continue" button
    Then Page shows solicitor address details error for postcode

    # Fix validation errors and continue
    When I fill in "Building and street" with "Street A"
    And I fill in "Town or city" with "London"
    And I fill in "Country" with "United Kingdom"
    And I fill in "Postcode" with "SW1A 1AA"
    And I click the "Continue" button
    Then I should see the solicitor contact details page

    # Provoke validation errors
    When I click the "Continue" button
    Then Page shows solicitor contact details errors

    When I fill in "Email address" with "¡€#"
    And I fill in "Phone number" with "¡€#"
    And I fill in "DX number" with "¡€#"
    And I click the "Continue" button
    Then Page shows solicitor contact details errors for format

    # Fix validation errors and continue
    When I fill in "Email address" with "dwayne@email.com"
    And I fill in "Phone number" with "00000000000"
    And I fill in "DX number" with "123-456"
    And I click the "Continue" button
    Then I should see the respondent names page

    When I visit "steps/applicant/has_solicitor"
    And I should see the has solicitor page
    Then I choose "No"
    And I click the "Continue" button
    Then I should see the respondent names page
    And the confidential changes end

  @happy_path
  Scenario: Test timeout on applicant personal details
    When I should see "Enter your name"
    And I should see "Enter a new name"
    And I wait and click the "Continue" button
    Then I should see "Sorry, you'll have to start again"
    And the confidential changes end
    
  @happy_path
  Scenario: Test timeout on solicitor representative details journey
    When I visit "steps/solicitor/personal_details"
    And I should see "Details of solicitor"
    And I wait and click the "Continue" button
    Then I should see "Sorry, you'll have to start again"
    And the confidential changes end