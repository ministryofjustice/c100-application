When(/^I complete the applicant details journey keeping my contact details private$/) do
  # Navigate to applicant names
  applicant_names_page.submit_names('Jane', 'Doe')

  # Privacy questions
  applicant_privacy_known_page.submit_dont_know
  applicant_privacy_preferences_page.submit_yes(address_private: true)
  applicant_refuge_page.submit_no
  applicant_privacy_summary_page.continue_to_next_step

  # Personal details
  applicant_personal_details_page.submit_personal_details(
    has_previous_name: 'yes',
    previous_name: 'Olivia Doe Jr',
    gender: 'female',
    age: 30,
    birthplace: 'London'
  )

  # Relationship
  applicant_relationship_page.submit_relationship('Mother')
  applicant_relationship_page.submit_relationship('Mother')

  # Address
  address_lookup_page.click_outside_uk
  applicant_address_details_page.submit_address_details(
    address_line_1: 'Windsor Castle',
    town: 'Windsor',
    country: 'United Kingdom',
    residence_5_years: 'yes'
  )

  # Contact details
  applicant_contact_details_page.submit_contact_details(
    email: 'jane_doe@gmail.com',
    phone: '00000888888',
    voicemail_consent: 'yes'
  )
end

Then(/^I should be taken to the applicant details page$/) do
  expect(applicant_names_page).to be_displayed
end