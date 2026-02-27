Then('I should be on the consent order page') do
  expect(consent_order_page).to be_displayed
end

And('I submit the consent order form with an existing consent order') do
  consent_order_page.submit_existing_consent_order
end

And('I submit the consent order form without an existing consent order') do
  consent_order_page.submit_without_consent_order
end

And('I have no safety concerns about the children') do
  expect(safety_concern_abduction_page).to be_displayed
  safety_concern_abduction_page.submit_no

  expect(safety_concern_substance_page).to be_displayed
  safety_concern_substance_page.submit_no

  expect(safety_concern_abuse_page).to be_displayed
  safety_concern_abuse_page.submit_no

  expect(safety_concern_domestic_page).to be_displayed
  safety_concern_domestic_page.submit_no

  expect(safety_concern_other_page).to be_displayed
  safety_concern_other_page.submit_no
end

And('I have tried all alternative ways to reach an agreement') do
  expect(alternative_page).to be_displayed
  alternative_page.continue_to_next_step

  expect(alternative_negotiation_page).to be_displayed
  alternative_negotiation_page.submit_yes

  expect(alternative_mediation_page).to be_displayed
  alternative_mediation_page.submit_no

  expect(alternative_lawyer_page).to be_displayed
  alternative_lawyer_page.submit_yes

  expect(alternative_collaborative_law_page).to be_displayed
  alternative_collaborative_law_page.submit_yes
end

Then('I enter details for a {string} year old child') do |age|
  expect(children_names_page).to be_displayed
  children_names_page.add_child('John', 'Smith Jr')

  expect(child_personal_details_page).to be_displayed
  child_personal_details_page.submit_child_personal_details(
    gender: 'male',
    age: age
  )

  expect(child_orders_page).to be_displayed
  child_orders_page.submit_all_child_orders

  expect(special_guardianship_page).to be_displayed
  special_guardianship_page.submit_no
end

Then('I state that the {string} has parental responsibility for the child') do |persons|
  expect(parental_responsibility_page).to be_displayed
  parental_responsibility_page.submit_responsibility(persons)
end

And("I submit that I don't know any additional details for the child") do
  expect(child_additional_details_page).to be_displayed
  child_additional_details_page.submit_dont_know_to_both
end

And("I don't have any other children") do
  expect(has_other_children_page).to be_displayed
  has_other_children_page.submit_no
end

And("I enter the details for a solicitor") do
  expect(applicant_has_solicitor_page).to be_displayed
  applicant_has_solicitor_page.submit_yes

  expect(solicitor_personal_details_page).to be_displayed
  solicitor_personal_details_page.submit_solicitor_details(
    full_name: 'Annalise Keating',
    firm_name: 'Keating Law Firm')

  expect(solicitor_address_details_page).to be_displayed
  solicitor_address_details_page.submit_address_details(
    address_line_1: 'Windsor Castle',
    town: 'Windsor',
    country: 'United Kingdom',
    postcode: 'SL4 1QF'
  )

  expect(solicitor_contact_details_page).to be_displayed
  solicitor_contact_details_page.submit_contact_details(
    email: 'annalise@law.com',
    phone: '00000000000',
    dx_number: '00000000000'
  )
end

And("I navigate the respondent details journey") do
  expect(respondent_names_page).to be_displayed
  respondent_names_page.submit_names('Jane', 'Doe')

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