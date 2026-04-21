When(/^I navigate the MIAM exemption journey$/) do
  expect(consent_order_page).to be_displayed
  consent_order_page.submit_without_consent_order

  expect(child_protection_case_page).to be_displayed
  child_protection_case_page.submit_no

  expect(miam_acknowledgement_page).to be_displayed
  miam_acknowledgement_page.submit_voucher_scheme_no

  expect(miam_attended_page).to be_displayed
  miam_attended_page.submit_no

  expect(miam_exemption_claim_page).to be_displayed
  miam_exemption_claim_page.submit_yes

  expect(miam_exemptions_domestic_page).to be_displayed
  miam_exemptions_domestic_page.submit_none_of_these

  expect(miam_exemptions_protection_page).to be_displayed
  miam_exemptions_protection_page.submit_none_of_these

  expect(miam_exemptions_urgency_page).to be_displayed
  miam_exemptions_urgency_page.submit_none_of_these

  expect(miam_exemptions_adr_page).to be_displayed
  miam_exemptions_adr_page.submit_none_of_these

  expect(miam_exemptions_misc_page).to be_displayed
  miam_exemptions_misc_page.submit_without_notice_hearing
end

And(/^I have no abuse or physical abuse concerns about the children$/) do
  expect(abuse_concerns_page).to be_displayed
  abuse_concerns_page.continue_to_next_step

  expect(abuse_concerns_children_info_page).to be_displayed
  abuse_concerns_children_info_page.continue_to_next_step

  expect(abuse_concerns_question_page).to be_displayed
  abuse_concerns_question_page.submit_no

  expect(abuse_concerns_physical_page).to be_displayed
  abuse_concerns_physical_page.submit_no
end

And(/^I do have financial concerns about the children$/) do
  expect(abuse_concerns_financial_page).to be_displayed
  abuse_concerns_financial_page.submit_yes

  expect(abuse_concerns_financial_details_page).to be_displayed
  abuse_concerns_financial_details_page.submit_concern_details(
    concern_details: 'Details of the abuse',
    behaviour_start: 'It started a year ago',
    behaviour_stop: 'It stopped earlier this month',
    asked_for_help: false,
  )
end

And(/^I have no psychological or emotional abuse concerns about the children$/) do
  expect(abuse_concerns_psychological_page).to be_displayed
  abuse_concerns_psychological_page.submit_no

  expect(abuse_concerns_emotional_page).to be_displayed
  abuse_concerns_emotional_page.submit_no
end

And(/^I do have other abuse concerns about the children$/) do
  expect(abuse_concerns_children_other_page).to be_displayed
  abuse_concerns_children_other_page.submit_yes

  expect(abuse_concerns_children_other_details_page).to be_displayed
  abuse_concerns_children_other_details_page.submit_concern_details(
    concern_details: 'Description of safety concerns I have',
    behaviour_start: 'This started about a year ago',
    behaviour_stop: 'It stopped earlier this month',
    asked_for_help: false
  )
end

And(/^I don't have any safety concerns about myself$/) do
  expect(abuse_concerns_applicant_info_page).to be_displayed
  abuse_concerns_applicant_info_page.continue_to_next_step

  expect(abuse_concerns_applicant_question_page).to be_displayed
  abuse_concerns_applicant_question_page.submit_no

  expect(abuse_concerns_applicant_physical_page).to be_displayed
  abuse_concerns_applicant_physical_page.submit_no

  expect(abuse_concerns_applicant_financial_page).to be_displayed
  abuse_concerns_applicant_financial_page.submit_no

  expect(abuse_concerns_applicant_psychological_page).to be_displayed
  abuse_concerns_applicant_psychological_page.submit_no

  expect(abuse_concerns_applicant_emotional_page).to be_displayed
  abuse_concerns_applicant_emotional_page.submit_no

  expect(abuse_concerns_applicant_other_page).to be_displayed
  abuse_concerns_applicant_other_page.submit_no

  expect(applicant_has_protection_court_order_page).to be_displayed
  applicant_has_protection_court_order_page.submit_no

  expect(abuse_concerns_contact_page).to be_displayed
  abuse_concerns_contact_page.submit_contact_details(
    contact_type: 'no',
    being_in_touch: 'no'
  )
end

And(/^I ask the court to also decide "(.*)"$/) do |arg|
  expect(petition_protection_page).to be_displayed
  petition_protection_page.submit_yes(details: arg)
end


And(/^evidence "(is|isn't)" provided for the MIAM exemption$/) do |arg|
  expect(miam_exemptions_reasons_page).to be_displayed
  if arg == 'is'
    miam_exemptions_reasons_page.submit_yes

    expect(miam_exemptions_exemption_upload_page).to be_displayed
    file_path = File.absolute_path('features/support/sample_file/image.jpg')
    miam_exemptions_exemption_upload_page.upload_file(file_path)

    expect(miam_exemptions_details_page).to be_displayed
    miam_exemptions_details_page.submit_exemption_details('exemption reason')
  else
    miam_exemptions_reasons_page.submit_no_exemption_reasons('Supporting reason')

    expect(miam_exemptions_details_page).to be_displayed
    miam_exemptions_details_page.continue_without_filling
  end

  expect(miam_exemptions_reasons_playback_page).to be_displayed
  miam_exemptions_reasons_playback_page.continue
end

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
  expect(safety_concern_page).to be_displayed
  safety_concern_page.continue_to_next_step

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

And('I navigate the abduction risk journey') do
  expect(safety_concern_page).to be_displayed
  safety_concern_page.continue_to_next_step

  expect(safety_concern_abduction_page).to be_displayed
  safety_concern_abduction_page.submit_yes

  expect(abduction_international_page).to be_displayed
  abduction_international_page.submit_yes

  expect(abduction_children_have_passport_page).to be_displayed
  abduction_children_have_passport_page.submit_yes

  expect(abduction_passport_details_page).to be_displayed
  abduction_passport_details_page.submit_no_multiple_passports
  abduction_passport_details_page.submit_passport_possession('mother')
  abduction_passport_details_page.continue_to_next_step

  expect(abduction_previous_attempt_page).to be_displayed
  abduction_previous_attempt_page.submit_no

  expect(abduction_risk_details_page).to be_displayed
  abduction_risk_details_page.submit_risk_details('They might be taken by their other parent', 'The children are with me')
end

And('I have no concerns about drug, alcohol or substance abuse') do
  expect(safety_concern_substance_page).to be_displayed
  safety_concern_substance_page.submit_no
end

And('I ask the court to decide who the children live with and when') do
  expect(petition_orders_page).to be_displayed
  petition_orders_page.select_issue_home
  petition_orders_page.submit

  expect(petition_playback_page).to be_displayed
  expect(petition_playback_page.content.child_arrangements_order).to be_visible
  expect(petition_playback_page.content.child_arrangements_home).to be_visible
  petition_playback_page.continue_to_next_step
end

And('I understand the process of going to court') do
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
  child_arrangements_order = 'Child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order'
  expect(cya_page.opening_questions.consent_order_application.answer).to eq(child_arrangements_order)
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
  expect(cya_page.children_details.personal_details[0].dob).to eq('17-03-2024')
  expect(cya_page.children_details.personal_details[0].sex).to eq('Male')
  expect(cya_page.children_details.child_orders[0].answer).to eq('Child Arrangements Order')
  expect(cya_page.children_details.special_guardianship_order[0]).to be_no
  expect(cya_page.children_details.parental_responsibility[0].answer).to eq('Father')

  # children further information
  expect(cya_page.children_further_info.known_to_authorities).to be_dont_know
  expect(cya_page.children_further_info.protection_plan).to be_dont_know
  expect(cya_page.children_further_info.has_other_children).to be_no

  # applicants details
  expect(cya_page.applicants_details.applicants.count).to eq(1) # 1 applicant only
  expect(cya_page.applicants_details.privacy_known[0]).to be_yes
  expect(cya_page.applicants_details.contact_details_private[0]).to be_no
  expect(cya_page.applicants_details.refuge[0]).to be_no
  expect(cya_page.applicants_details.full_name[0].answer).to eq('John Doe Senior')
  expect(cya_page.applicants_details.personal_details[0].dob).to eq('25-05-1998')
  expect(cya_page.applicants_details.personal_details[0].sex).to eq('Male')
  expect(cya_page.applicants_details.personal_details[0].birthplace).to eq('Manchester')
  expect(cya_page.applicants_details.relationship_to_child[0].answer).to eq('Father')
  expect(cya_page.applicants_details.address_details[0].address.answer).to eq('Test street, London, United Kingdom')
  expect(cya_page.applicants_details.address_details[0].lived_at_5_years).to be_yes
  expect(cya_page.applicants_details.contact_details[0].email_provided).to be_yes
  expect(cya_page.applicants_details.contact_details[0].email.answer).to eq('john@email.com')
  expect(cya_page.applicants_details.contact_details[0].phone_number.answer).to eq('00000000000')
  expect(cya_page.applicants_details.contact_details[0].voicemail_consent.answer).to eq('Yes, the court can leave a voicemail')

  # solicitor details
  expect(cya_page.solicitor_details.has_solicitor).to be_yes
  expect(cya_page.solicitor_details.personal_details.full_name.answer).to eq('Annalise Keating')
  expect(cya_page.solicitor_details.personal_details.firm_name.answer).to eq('Keating Law Firm')
  expect(cya_page.solicitor_details.address_details.address.answer).to eq('Windsor Castle, Windsor, United Kingdom, SL4 1QF')
  expect(cya_page.solicitor_details.contact_details.email.answer).to eq('annalise@law.com')
  expect(cya_page.solicitor_details.contact_details.phone_number.answer).to eq('00000000000')
  expect(cya_page.solicitor_details.contact_details.dx_number.answer).to eq('00000000000')

  # respondent details
  expect(cya_page.respondent_details.full_name.answer).to eq('Jane Doe')

  # other parties details
  expect(cya_page.other_parties_details.has_other_parties).to be_no

  # children residence
  expect(cya_page.children_residence.child[0].child_name).to eq('John Smith Jr')
  expect(cya_page.children_residence.child[0].residence).to eq('John Doe Senior')

  # other court cases
  expect(cya_page.other_court_cases.has_other_court_cases).to be_yes
  expect(cya_page.other_court_cases.details.children_names.answer).to eq('John Doe Jnr')
  expect(cya_page.other_court_cases.details.court_name.answer).to eq('London Court')
  expect(cya_page.other_court_cases.details.proceedings_date.answer).to eq('2020')
  expect(cya_page.other_court_cases.details.order_types.answer).to eq('Legal hearing')
  expect(cya_page.other_court_cases.details.previous_details.answer).to eq('Lasted for weeks')

  # application reasons
  expect(cya_page.application_reasons.details.answer).to eq('I fear for the safety of Jane Doe Jnr and I want her to be safe')
  expect(cya_page.application_reasons.has_existing_court_order).to be_no

  # urgent hearing
  expect(cya_page.urgent_hearing.needs_urgent_hearing).to be_no

  # without notice hearing
  expect(cya_page.without_notice_hearing.asking_for_without_notice_hearing).to be_no

  # international element
  expect(cya_page.international_info.international_resident).to be_no
  expect(cya_page.international_info.international_jurisdiction.can_apply_outside_en_cy).to be_yes
  expect(cya_page.international_info.international_jurisdiction.details.answer).to eq('Details')
  expect(cya_page.international_info.international_request).to be_no

  # litigation capacity
  expect(cya_page.litigation_capacity.reduced_litigation_capacity).to be_no

  # attending court
  expect(cya_page.attending_court.requires_intermediary_help).to be_no
  expect(cya_page.attending_court.language_requirements.interpreter).to be_not_needed
  expect(cya_page.attending_court.language_requirements.sign_language_interpreter).to be_not_needed
  expect(cya_page.attending_court.language_requirements.welsh_language).to be_not_needed
  expect(cya_page.attending_court.safety_arrangements).to be_none_selected
  expect(cya_page.attending_court.special_assistance.details).to be_none_selected
  expect(cya_page.attending_court.special_assistance.additional_details.answer).to eq('We need lots of light')

  # submission
  expect(cya_page.submission.email.answer).to eq('john@gmail.com')

  # payment
  expect(cya_page.payment.payment_method.type.answer).to eq('Help with fees')
  expect(cya_page.payment.payment_method.hwf_ref_no.answer).to eq('HWF-123-456')

end