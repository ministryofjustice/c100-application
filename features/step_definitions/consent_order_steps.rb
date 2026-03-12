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

And('I ask the court to decide who the children live with and when') do
  expect(petition_orders_page).to be_displayed
  petition_orders_page.select_issue_home
  petition_orders_page.submit

  expect(petition_playback_page).to be_displayed
  expect(petition_playback_page.content.child_arrangements_order).to be_visible
  expect(petition_playback_page.content.child_arrangements_home).to be_visible
  petition_playback_page.continue_to_next_step

  expect(alternative_court_page).to be_displayed
  alternative_court_page.acknowledge_and_continue
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

And("there are no other people who should know about the application") do
  expect(has_other_parties_page).to be_displayed
  has_other_parties_page.submit_no
end

And("the child lives with {string}") do |person|
  expect(child_residence_page).to be_displayed
  child_residence_page.submit_residence(person)
end

And("I enter details of previous court proceedings") do
  expect(previous_proceedings_page).to be_displayed
  previous_proceedings_page.submit_yes

  expect(previous_court_proceedings_page).to be_displayed
  previous_court_proceedings_page.submit_previous_proceedings(
    children_names: 'John Doe Jnr',
    court_name: 'London Court',
    proceedings_date: '2020',
    proceedings_type: 'Legal hearing',
    details: 'Lasted for weeks'
  )
end

And(/^there "(is|isn't)" a court order requiring permission to make this application$/) do |arg|
  expect(existing_court_order_page).to be_displayed
  existing_court_order_page.submit(arg == 'is' ? 'yes' : 'no')
end

And("I am not asking for an urgent or without notice hearing") do
  expect(urgent_hearing_page).to be_displayed
  urgent_hearing_page.submit_no

  expect(without_notice_page).to be_displayed
  without_notice_page.submit_no
end

And("I navigate the international issues journey") do
  expect(international_resident_page).to be_displayed
  international_resident_page.submit_no

  expect(international_jurisdiction_page).to be_displayed
  international_jurisdiction_page.submit_yes('Details')

  expect(international_request_page).to be_displayed
  international_request_page.submit_no
end

And("I give my reason for the application as {string}") do |reason|
  expect(application_details_page).to be_displayed
  application_details_page.submit_details(reason)
end

And(/^there "(are|aren't)" factors that may affect any adult in this application taking part in the court proceedings$/) do |arg|
  expect(litigation_capacity_page).to be_displayed
  litigation_capacity_page.submit(arg == 'are' ? 'yes' : 'no')
end

And("I have no issues attending court") do
  expect(attending_court_intermediary_page).to be_displayed
  attending_court_intermediary_page.submit_no

  expect(attending_court_language_page).to be_displayed
  attending_court_language_page.continue_without_filling

  expect(attending_court_special_arrangements_page).to be_displayed
  attending_court_special_arrangements_page.continue_without_filling

  expect(attending_court_special_assistance_page).to be_displayed
  attending_court_special_assistance_page.submit_special_assistance(
    special_assistance_details: 'We need lots of light'
  )
end

And("I submit the application with email {string}") do |email|
  expect(submission_page).to be_displayed
  submission_page.submit_receipt_email(email)

  expect(submission_email_check_page).to be_displayed
  submission_email = submission_email_check_page.content.receipt_email.text
  expect(submission_email).to include(email)
  submission_email_check_page.submit_yes
end

And("I pay using Help With Fees with reference {string}") do |reference|
  application_payment_page.pay_by_help_with_fees(reference)
end

And("I should see the check your answers page") do
  expect(cya_page).to be_displayed
  expect(cya_page.content).to have_header

  # opening questions
  expect(cya_page.opening_questions.children_postcode.answer).to eq('MK9 2DT')
  expect(cya_page.opening_questions.consent_order_application.answer).to eq('Child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order')
  expect(cya_page.opening_questions.child_protection_cases).to be_yes
  
  # miam exemptions
  expect(cya_page.miam_exemptions.exemption_details).to be_not_applicable
  expect(cya_page.miam_exemptions.exemption).to be_not_applicable

  # safety concerns
  expect(cya_page.safety_concerns.risk_of_abduction).to be_no
  expect(cya_page.safety_concerns.substance_abuse).to be_no
  expect(cya_page.safety_concerns.children_abuse).to be_no
  expect(cya_page.safety_concerns.domestic_abuse).to be_no
  expect(cya_page.safety_concerns.other_abuse).to be_no

  # nature of application
  expect(cya_page.nature_of_application.child_arrangements_orders.answer).to eq('Decide who they live with and when')

  # alternatives
  expect(cya_page.alternatives.alternative_negotiation_tools).to be_yes
  expect(cya_page.alternatives.alternative_mediation).to be_no
  expect(cya_page.alternatives.alternative_lawyer_negotiation).to be_yes
  expect(cya_page.alternatives.alternative_collaborative_law).to be_yes

  # children details
  expect(cya_page.children_details.children.count).to eq(1) # 1 child only
  expect(cya_page.children_details.full_name[0].answer).to eq('John Smith Jr')
  expect(cya_page.children_details.personal_details[0].dob).to eq('11-03-2024')
  expect(cya_page.children_details.personal_details[0].sex).to eq('Male')
  expect(cya_page.children_details.child_orders[0].answer).to eq('Child Arrangements Order')
  expect(cya_page.children_details.special_guardianship_order[0]).to be_no
  expect(cya_page.children_details.parental_responsibility[0].answer).to eq('Father')

  # children further information
  expect(cya_page.children_further_information.known_to_authorities).to be_dont_know
  expect(cya_page.children_further_information.protection_plan).to be_dont_know
  expect(cya_page.children_further_information.other_details).to be_no
end