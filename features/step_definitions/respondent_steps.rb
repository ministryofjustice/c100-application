And(/^I navigate the respondent details journey$/) do
  expect(respondent_names_page).to be_displayed
  respondent_names_page.submit_names('Jane', 'Doe')

  expect(respondent_refuge_page).to be_displayed
  respondent_refuge_page.submit_no

  expect(respondent_personal_details_page).to be_displayed
  respondent_personal_details_page.submit_personal_details(
    has_previous_name: 'no',
    gender: 'female',
    age: '30',
    birthplace: 'London'
  )

  expect(respondent_relationship_page).to be_displayed
  respondent_relationship_page.submit_relationship('Mother')

  respondent_address_lookup_page.click_outside_uk
  respondent_address_details_page.submit_address_details(
    address_line_1: 'Windsor Castle',
    town: 'Windsor',
    country: 'United Kingdom',
    residence_5_years: 'yes'
  )

  respondent_contact_details_page.submit_contact_details(
    email: 'Jane@Hotmail.com',
    phone: '00000000000'
  )
end

And(/^I navigate the respondent details journey with an additional child$/) do
  expect(respondent_names_page).to be_displayed
  respondent_names_page.submit_names('John', 'Doe')

  expect(respondent_refuge_page).to be_displayed
  respondent_refuge_page.submit_no

  expect(respondent_personal_details_page).to be_displayed
  respondent_personal_details_page.submit_personal_details(
    has_previous_name: 'no',
    gender: 'male',
    age: '35',
    birthplace: 'Windsor'
  )

  expect(respondent_relationship_page).to be_displayed
  respondent_relationship_page.submit_relationship('Father')
  respondent_relationship_page.submit_relationship('Father')

  respondent_address_lookup_page.click_outside_uk
  respondent_address_details_page.submit_address_details(
    address_line_1: 'Windsor Castle',
    town: 'Windsor',
    country: 'United Kingdom',
    residence_5_years: 'no'
  )

  respondent_contact_details_page.submit_contact_details(
    email: 'john-doe@hotmail.com',
    phone: '00000999999'
  )
end

And(/^there "(are|aren't)" any other people who should know about the application$/) do |arg|
  expect(has_other_parties_page).to be_displayed
  has_other_parties_page.submit(arg == 'are' ? 'yes' : 'no')
end

And(/^I complete the other party details journey with an additional child$/) do
  expect(other_party_names_page).to be_displayed
  other_party_names_page.submit_names('Judy', 'Sitter')

  expect(other_party_personal_details_page).to be_displayed
  other_party_personal_details_page.submit_personal_details(
    has_previous_name: false,
    gender: 'female',
    age: '35',
  )

  applicant_relationship_page.submit_relationship('Caregiver')
  applicant_relationship_page.submit_relationship('Caregiver')

  respondent_address_lookup_page.click_outside_uk
  other_party_address_details_page.submit_address_details(
    address_line_1: '10 Downing Street',
    town: 'London',
    country: 'United Kingdom',
    postcode: 'SW1A 2AA'
  )
end

And(/^I complete the other party details journey$/) do
  expect(other_party_names_page).to be_displayed
  other_party_names_page.submit_names('Cassie', 'Doe')

  expect(other_party_personal_details_page).to be_displayed
  other_party_personal_details_page.submit_personal_details(
    has_previous_name: false,
    gender: 'female',
    age: '30',
  )

  applicant_relationship_page.submit_relationship('Caregiver')

  respondent_address_lookup_page.click_outside_uk
  other_party_address_details_page.submit_address_details(
    address_line_1: '10 Downing Street',
    town: 'London',
    country: 'United Kingdom',
    postcode: 'SW1A 2AA'
  )
end