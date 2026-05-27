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

When(/^I navigate the MIAM journey$/) do
  expect(consent_order_page).to be_displayed
  consent_order_page.submit_without_consent_order

  expect(child_protection_case_page).to be_displayed
  child_protection_case_page.submit_no

  expect(miam_acknowledgement_page).to be_displayed
  miam_acknowledgement_page.submit_voucher_scheme_no

  expect(miam_attended_page).to be_displayed
  miam_attended_page.submit_yes
  
  expect(miam_certification_page).to be_displayed
  miam_certification_page.submit_no

  # test unhappy path
  expect(miam_certification_exit_page).to be_displayed
  miam_certification_exit_page.go_back

  expect(miam_certification_page).to be_displayed
  miam_certification_page.submit_yes

  expect(miam_certification_upload_page).to be_displayed
  file_path = File.absolute_path('features/support/sample_file/image.jpg')
  miam_certification_upload_page.upload_file(file_path)
end

When(/^I navigate the MIAM journey with a child protection case$/) do
  expect(consent_order_page).to be_displayed
  consent_order_page.submit_without_consent_order

  expect(child_protection_case_page).to be_displayed
  child_protection_case_page.submit_yes

  expect(child_protection_info_page).to be_displayed
  child_protection_info_page.continue_to_next_step
end

When(/^I navigate the Consent Order journey with a child protection case$/) do
  expect(consent_order_page).to be_displayed
  consent_order_page.submit_existing_consent_order

  file_path = File.absolute_path('features/support/sample_file/image.jpg')
  upload_consent_order_page.upload_file(file_path)

  child_protection_info_page.continue_to_next_step

  expect(child_protection_case_page).to be_displayed
  child_protection_case_page.submit_yes

  expect(safety_concern_page).to be_displayed
  safety_concern_page.continue_to_next_step
end

When(/^I navigate back to the consent order page$/) do
  expect(safety_concern_page).to be_displayed
  safety_concern_page.go_back

  expect(child_protection_info_page).to be_displayed
  child_protection_info_page.go_back

  expect(child_protection_case_page).to be_displayed
  child_protection_case_page.go_back
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

And(/^I "(do|don't)" have psychological and emotional abuse concerns about the children$/) do |arg|
  expect(abuse_concerns_psychological_page).to be_displayed
  if arg == 'do'
    abuse_concerns_psychological_page.submit_yes

    expect(abuse_concerns_psychological_details_page).to be_displayed
    abuse_concerns_psychological_details_page.submit_concern_details(
      concern_details: 'The respondent guilt tripped the kids',
      behaviour_start: 'Many years ago',
      behaviour_stop: 'About two years ago',
      asked_for_help: false
    )
  else
    abuse_concerns_psychological_page.submit_no
  end

  expect(abuse_concerns_emotional_page).to be_displayed
  if arg == 'do'
    abuse_concerns_emotional_page.submit_yes

    expect(abuse_concerns_emotional_details_page).to be_displayed
    abuse_concerns_emotional_details_page.submit_concern_details(
      concern_details: 'The respondent was mean to the kids',
      behaviour_start: 'Many years ago',
      behaviour_stop: 'About two years ago',
      asked_for_help: false
    )
  else
    abuse_concerns_emotional_page.submit_no
  end
end

And(/^I "(do|don't)" have other abuse concerns about the children$/) do |arg|
  expect(abuse_concerns_children_other_page).to be_displayed
  if arg == 'do'
    abuse_concerns_children_other_page.submit_yes

    expect(abuse_concerns_children_other_details_page).to be_displayed
    abuse_concerns_children_other_details_page.submit_concern_details(
      concern_details: 'Description of safety concerns I have',
      behaviour_start: 'This started about a year ago',
      behaviour_stop: 'It stopped earlier this month',
      asked_for_help: false
    )
  else
    abuse_concerns_children_other_page.submit_no
  end
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

And(/^I "(have|haven't)" been abused by the respondent$/) do |arg|
  expect(abuse_concerns_applicant_info_page).to be_displayed
  abuse_concerns_applicant_info_page.continue_to_next_step
  
  expect(abuse_concerns_applicant_question_page).to be_displayed
  if arg == 'have'
    abuse_concerns_applicant_question_page.submit_yes

    expect(abuse_concerns_applicant_question_details_page).to be_displayed
    abuse_concerns_applicant_question_details_page.submit_concern_details(
      concern_details: 'Description of sexual abuse',
      behaviour_start: 'Many years ago',
      behaviour_stop: 'About two years ago',
      asked_for_help: false
    )
  else
    abuse_concerns_applicant_question_page.submit_no
  end
end

And(/^I "(have|haven't)" been physically abused by the respondent$/) do |arg|
  expect(abuse_concerns_applicant_physical_page).to be_displayed
  if arg == 'have'
    abuse_concerns_applicant_physical_page.submit_yes

    expect(abuse_concerns_applicant_physical_details_page).to be_displayed
    abuse_concerns_applicant_physical_details_page.submit_concern_details(
      concern_details: 'The respondent hit me',
      behaviour_start: 'Many years ago',
      behaviour_stop: 'About two years ago',
      asked_for_help: false
    )
  else
    abuse_concerns_applicant_physical_page.submit_no
  end
end

And(/^I "(have|haven't)" been financially abused by the respondent$/) do |arg|
  expect(abuse_concerns_applicant_financial_page).to be_displayed
  if arg == 'have'
    abuse_concerns_applicant_financial_page.submit_yes

    expect(abuse_concerns_applicant_financial_details_page).to be_displayed
    abuse_concerns_applicant_financial_details_page.submit_concern_details(
      concern_details: 'The respondent took my money',
      behaviour_start: 'Many years ago',
      behaviour_stop: 'About two years ago',
      asked_for_help: false
    )
  else
    abuse_concerns_applicant_financial_page.submit_no
  end
end

And(/^I "(have|haven't)" been psychologically and emotionally abused by the respondent$/) do |arg|
  expect(abuse_concerns_applicant_psychological_page).to be_displayed
  if arg == 'have'
    abuse_concerns_applicant_psychological_page.submit_yes

    expect(abuse_concerns_applicant_psychological_details_page).to be_displayed
    abuse_concerns_applicant_psychological_details_page.submit_concern_details(
      concern_details: 'The respondent psychologically abused me',
      behaviour_start: 'Many years ago',
      behaviour_stop: 'About two years ago',
      asked_for_help: false
    )
  else
    abuse_concerns_applicant_psychological_page.submit_no
  end

  expect(abuse_concerns_applicant_emotional_page).to be_displayed
  if arg == 'have'
    abuse_concerns_applicant_emotional_page.submit_yes

    expect(abuse_concerns_applicant_emotional_details_page).to be_displayed
    abuse_concerns_applicant_emotional_details_page.submit_concern_details(
      concern_details: 'The respondent emotionally abused me',
      behaviour_start: 'Many years ago',
      behaviour_stop: 'About two years ago',
      asked_for_help: false
    )
  else
    abuse_concerns_applicant_emotional_page.submit_no
  end
end

And(/^I "(do|don't)" have any other concerns about my welfare$/) do |arg|
  expect(abuse_concerns_applicant_other_page).to be_displayed
  if arg == 'do'
    abuse_concerns_applicant_other_page.submit_yes

    expect(abuse_concerns_applicant_other_details_page).to be_displayed
    abuse_concerns_applicant_other_details_page.submit_concern_details(
      concern_details: 'Description of other abuse',
      behaviour_start: 'Many years ago',
      behaviour_stop: 'About two years ago',
      asked_for_help: false
    )
  else
    abuse_concerns_applicant_other_page.submit_no
  end
end

And(/^I "(have|haven't)" had or currently have court orders made for my protection$/) do |arg|
  expect(applicant_has_protection_court_order_page).to be_displayed
  if arg == 'have'
    applicant_has_protection_court_order_page.submit_yes
  else
    applicant_has_protection_court_order_page.submit_no
  end
end

And(/^I "(do|don't)" agree to the children having contact with the other people in this application$/) do |arg|
  expect(abuse_concerns_contact_page).to be_displayed
  if arg == 'do'
    abuse_concerns_contact_page.submit_contact_details(
      contact_type: 'yes',
      being_in_touch: 'yes'
    )
  else
    abuse_concerns_contact_page.submit_contact_details(
      contact_type: 'no',
      being_in_touch: 'no'
    )
  end
end

And(/^I ask the court to also decide "(.*)"$/) do |arg|
  expect(petition_protection_page).to be_displayed
  petition_protection_page.submit_yes(details: arg)
end

And(/^I am not asking the court to decide on any other issues$/) do
  expect(petition_protection_page).to be_displayed
  petition_protection_page.submit_no
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

And(/^I "(do|don't)" have abduction concerns about the children$/) do |arg|
  expect(safety_concern_abduction_page).to be_displayed
  if arg == 'do'
    safety_concern_abduction_page.submit_yes
  else
    safety_concern_abduction_page.submit_no
  end
end


And(/^I "(do|don't)" have concerns about drug, alcohol or substance abuse$/) do |arg|
  expect(safety_concern_substance_page).to be_displayed
  if arg == 'do'
    safety_concern_substance_page.submit_yes("Alcoholic and drug abuse details")
  else
    safety_concern_substance_page.submit_no
  end
end

And(/^I "(do|don't)" have domestic abuse or child concerns about the children$/) do |arg|
  expect(safety_concern_abuse_page).to be_displayed
  if arg == 'do'
    safety_concern_abuse_page.submit_yes
  else
    safety_concern_abuse_page.submit_no
  end
end

When(/^I ask the court to decide on the following issues: "(.*)"$/) do |issues|
  expect(petition_orders_page).to be_displayed

  petition_orders_page.select_issue_home if issues.include?('who the children live with and when')
  petition_orders_page.select_issue_time if issues.include?('how much time they spend with each person')

  petition_orders_page.select_issue_specific_issues(
    holiday: issues.include?('a specific holiday or arrangement'),
    school: issues.include?('what school they’ll go to'),
    religion: issues.include?('a religious issue'),
    names: issues.include?('changing their names or surname'),
    medical: issues.include?('medical treatment'),
    moving: issues.include?('relocating the children to a different area in england and wales'),
    moving_abroad: issues.include?('relocating the children outside of england and wales'),
    child_return: issues.include?('returning the children to your care')
  )
  
  petition_orders_page.submit
end

Then(/^I should see the child arrangements order details for: "(.*)"$/) do |issue|
  expect(petition_playback_page).to be_displayed
  if issue.include?('who the children live with and when')
    expect(petition_playback_page.content.child_arrangements_home).to be_visible
  end
  if issue.include?('how much time they spend with each person')
    expect(petition_playback_page.content.child_arrangements_time).to be_visible
  end
  expect(petition_playback_page.content.child_arrangements_order).to be_visible
end

Then(/^I should see the specific issue order details for: "([^"]*)"$/) do |issues|
  selected_issues = issues.split(',').map(&:strip)
  
  expect(petition_playback_page).to be_displayed
  selected_issues.each do |issue|
    case issue
    when 'a specific holiday or arrangement'
      expect(petition_playback_page.content.specific_issues_holiday).to be_visible
    when 'what school they’ll go to'
      expect(petition_playback_page.content.specific_issues_school).to be_visible
    when 'a religious issue'
      expect(petition_playback_page.content.specific_issues_religion).to be_visible
    when 'changing their names or surname'
      expect(petition_playback_page.content.specific_issues_names).to be_visible
    when 'medical treatment'
      expect(petition_playback_page.content.specific_issues_medical).to be_visible
    when 'relocating the children to a different area in england and wales'
      expect(petition_playback_page.content.specific_issues_moving).to be_visible
    when 'relocating the children outside of england and wales'
      expect(petition_playback_page.content.specific_issues_moving_abroad).to be_visible
    when 'returning the children to your care'
      expect(petition_playback_page.content.specific_issues_child_return).to be_visible
    else
      raise ArgumentError, "Unknown specific issue: '#{issue}'"
    end
  end
end

And(/^I continue to the next step$/) do
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

Then(/^I enter details for a "(\d+)" year old child with a special guardianship order$/) do |age|
  expect(children_names_page).to be_displayed
  children_names_page.add_child('Alistair', 'Doe')

  expect(child_personal_details_page).to be_displayed
  child_personal_details_page.submit_child_personal_details(
    gender: 'male',
    age: age
  )

  expect(child_orders_page).to be_displayed
  child_orders_page.submit_all_child_orders

  expect(special_guardianship_page).to be_displayed
  special_guardianship_page.submit_yes
end

And(/^I enter details for another child who is "(.*)" years old$/) do |age|
  expect(other_children_names_page).to be_displayed
  other_children_names_page.add_child('Jane', 'Smith')

  expect(other_children_personal_details_page).to be_displayed
  other_children_personal_details_page.submit_child_personal_details(
    gender: 'female',
    age: age
  )
end

Then('I state that the {string} has parental responsibility for the child') do |persons|
  expect(parental_responsibility_page).to be_displayed
  parental_responsibility_page.submit_responsibility(persons)
end

And(/^I submit that the children have a child protection plan and are known to social services: "(.*)"$/) do |details|
  expect(child_additional_details_page).to be_displayed
  child_additional_details_page.submit_known_to_social_services(additional_details: details)
end

And("I submit that I don't know any additional details for the child") do
  expect(child_additional_details_page).to be_displayed
  child_additional_details_page.submit_dont_know_to_both
end

And(/^I "(do|don't)" have other children$/) do |arg|
  expect(has_other_children_page).to be_displayed
  if arg == 'do'
    has_other_children_page.submit_yes
  else
    has_other_children_page.submit_no
  end
end

And(/^I "(do|don't)" have a solicitor$/) do |arg|
  expect(applicant_has_solicitor_page).to be_displayed

  if arg == 'do'
    applicant_has_solicitor_page.submit_yes
  else
    applicant_has_solicitor_page.submit_no
  end
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

And("I navigate the respondent details journey with an additional child") do
  expect(respondent_names_page).to be_displayed
  respondent_names_page.submit_names('John', 'Doe')

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

And("the child lives with {string}") do |person|
  expect(child_residence_page).to be_displayed
  child_residence_page.submit_residence(person)
end

And(/^there "(has|hasn't)" been any court proceedings about the children$/) do |arg|
  expect(previous_proceedings_page).to be_displayed
  previous_proceedings_page.submit(arg == 'has' ? 'yes' : 'no')
end

And("I enter details of previous court proceedings") do
  expect(previous_proceedings_page).to be_displayed
  previous_proceedings_page.submit_yes

  expect(previous_court_proceedings_page).to be_displayed
  previous_court_proceedings_page.submit_previous_proceedings(
    children_names: 'John Smith Jr',
    court_name: 'London Court',
    proceedings_date: '2020',
    proceedings_type: 'Legal hearing',
    details: 'Lasted for weeks'
  )
end

And(/^I enter details of previous court proceedings with an additional child$/) do
  expect(previous_proceedings_page).to be_displayed
  previous_proceedings_page.submit_yes

  expect(previous_court_proceedings_page).to be_displayed
  previous_court_proceedings_page.submit_previous_proceedings(
    children_names: 'Emily Doe and John Doe',
    court_name: 'Aylesbury',
    proceedings_date: 'March 2020',
    proceedings_type: 'Care order',
    details: 'Emily Doe was involved in a care order which took place at Aylesbury court'
  )
end

And(/^there "(is|isn't)" a court order requiring permission to make this application$/) do |arg|
  expect(existing_court_order_page).to be_displayed
  if arg == 'is'
    existing_court_order_page.submit_yes('12345678', '01-01-2030')

    expect(existing_court_order_uploadable_page).to be_displayed
    existing_court_order_uploadable_page.submit_yes

    expect(existing_court_order_upload_page).to be_displayed
    file_path = File.absolute_path('features/support/sample_file/image.jpg')
    existing_court_order_upload_page.upload_file(file_path)
  else
    existing_court_order_page.submit_no
  end
end

And("I am not asking for an urgent or without notice hearing") do
  expect(urgent_hearing_page).to be_displayed
  urgent_hearing_page.submit_no

  expect(without_notice_page).to be_displayed
  without_notice_page.submit_no
end

And(/^I "(do|don't)" require an urgent and without notice hearing$/) do |arg|
  expect(urgent_hearing_page).to be_displayed
  if arg == 'do'
    urgent_hearing_page.submit_yes
    
    expect(urgent_hearing_details_page).to be_displayed
    urgent_hearing_details_page.submit(
      details: 'Alistair is in grave danger because of Jake Gyllenhaal',
      hearing_when: 'In the next four weeks',
      urgent: false
    )
  else
    urgent_hearing_page.submit_no
  end

  expect(without_notice_page).to be_displayed
  if arg == 'do'
    without_notice_page.submit_yes
    without_notice_details_page.submit(
      details: 'Alistair is in grave danger because of Jake Gyllenhaal and I need to rescue him',
      possible_frustrate: false,
      without_notice_impossible: false
    )
  else
    without_notice_page.submit_no
  end
end

And("I navigate the international issues journey") do
  expect(international_resident_page).to be_displayed
  international_resident_page.submit_no

  expect(international_jurisdiction_page).to be_displayed
  international_jurisdiction_page.submit_yes('Details')

  expect(international_request_page).to be_displayed
  international_request_page.submit_no
end

And(/^I navigate the international issues journey with an international resident$/) do
  expect(international_resident_page).to be_displayed
  international_resident_page.submit_yes("Emily's maternal grandparents are in Austria")

  expect(international_jurisdiction_page).to be_displayed
  international_jurisdiction_page.submit_no

  expect(international_request_page).to be_displayed
  international_request_page.submit_no
end

And(/^there isn't any international issues in this application$/) do
  expect(international_resident_page).to be_displayed
  international_resident_page.submit_no

  expect(international_jurisdiction_page).to be_displayed
  international_jurisdiction_page.submit_no

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

And(/^there "(are|aren't)" factors affecting ability to participate$/) do |arg|
  expect(litigation_capacity_details_page).to be_displayed
  litigation_capacity_details_page.continue_without_filling if arg == "aren't"
end

And(/^I navigate the attending court journey$/) do
  expect(attending_court_intermediary_page).to be_displayed
  attending_court_intermediary_page.submit_yes('Needed for the respondent')

  expect(attending_court_language_page).to be_displayed
  attending_court_language_page.submit_language_requirements(language_interpreter_details: 'German needed for respondent')

  expect(attending_court_special_arrangements_page).to be_displayed
  attending_court_special_arrangements_page.submit_special_arrangements(separate_waiting_rooms: true, special_arrangements_details: 'Please keep the time the kids are needed for to a minimum')

  expect(attending_court_special_assistance_page).to be_displayed
  attending_court_special_assistance_page.continue_without_filling
end

And(/^I navigate the attending court journey with safety arrangements$/) do
  expect(attending_court_intermediary_page).to be_displayed
  attending_court_intermediary_page.submit_yes('I need someone to communicate between me and the respondent')

  expect(attending_court_language_page).to be_displayed
  attending_court_language_page.submit_language_requirements(welsh_language_details: 'Needed for Jake Gyllenhaal')

  expect(attending_court_special_arrangements_page).to be_displayed
  attending_court_special_arrangements_page.submit_special_arrangements(separate_waiting_rooms: true, separate_entrance_exit: true)

  expect(attending_court_special_assistance_page).to be_displayed
  attending_court_special_assistance_page.continue_without_filling
end

And("I have no issues attending court") do
  expect(attending_court_intermediary_page).to be_displayed
  attending_court_intermediary_page.submit_no

  expect(attending_court_language_page).to be_displayed
  attending_court_language_page.continue_without_filling

  expect(attending_court_special_arrangements_page).to be_displayed
  attending_court_special_arrangements_page.continue_without_filling
end

And(/^I don't require special assistance when attending court$/) do
  expect(attending_court_special_assistance_page).to be_displayed
  attending_court_special_assistance_page.continue_without_filling
end

And(/^I require special assistance when attending court "(.*)"$/) do |arg|
  expect(attending_court_special_assistance_page).to be_displayed
  attending_court_special_assistance_page.submit_special_assistance(
    special_assistance_details: arg
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

And(/^I complete the applicant details journey keeping my contact details private$/) do
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