And(/^I submit that I "(do|don't)" have abuse or physical abuse concerns about the children$/) do |arg|
  answer = arg == 'do'

  expect(abuse_concerns_page).to be_fully_loaded
  abuse_concerns_page.click_continue_link

  expect(abuse_concerns_children_info_page).to be_fully_loaded
  abuse_concerns_children_info_page.click_continue_link

  expect(abuse_concerns_question_page).to be_fully_loaded
  abuse_concerns_question_page.submit(answer)

  expect(abuse_concerns_physical_page).to be_fully_loaded
  abuse_concerns_physical_page.submit(answer)
end

And(/^I submit that I "(do|don't)" have financial concerns about the children$/) do |arg|
  expect(abuse_concerns_financial_page).to be_fully_loaded

  if arg == "don't"
    abuse_concerns_financial_page.submit_no
    next
  end

  abuse_concerns_financial_page.submit_yes

  expect(abuse_concerns_financial_details_page).to be_fully_loaded
  abuse_concerns_financial_details_page.submit_concern_details(
    concern_details: 'Details of the abuse',
    behaviour_start: 'It started a year ago',
    behaviour_stop: 'It stopped earlier this month',
    asked_for_help: false,
  )
end

And(/^I submit that I "(do|don't)" have psychological abuse concerns about the children$/) do |arg|
  expect(abuse_concerns_psychological_page).to be_fully_loaded

  if arg == "don't"
    abuse_concerns_psychological_page.submit_no
    next
  end

  abuse_concerns_psychological_page.submit_yes

  expect(abuse_concerns_psychological_details_page).to be_fully_loaded
  abuse_concerns_psychological_details_page.submit_concern_details(
    concern_details: 'The respondent guilt tripped the kids',
    behaviour_start: 'Many years ago',
    behaviour_stop: 'About two years ago',
    asked_for_help: false
  )
end

And(/^I submit that I "(do|don't)" have emotional abuse concerns about the children$/) do |arg|
  expect(abuse_concerns_emotional_page).to be_fully_loaded

  if arg == "don't"
    abuse_concerns_emotional_page.submit_no
    next
  end

  abuse_concerns_emotional_page.submit_yes

  expect(abuse_concerns_emotional_details_page).to be_fully_loaded
  abuse_concerns_emotional_details_page.submit_concern_details(
    concern_details: 'The respondent was mean to the kids',
    behaviour_start: 'Many years ago',
    behaviour_stop: 'About two years ago',
    asked_for_help: false
  )
end

And(/^I submit that I "(do|don't)" have other abuse concerns about the children$/) do |arg|
  expect(abuse_concerns_children_other_page).to be_fully_loaded

  if arg == "don't"
    abuse_concerns_children_other_page.submit_no
    next
  end

  abuse_concerns_children_other_page.submit_yes

  expect(abuse_concerns_children_other_details_page).to be_fully_loaded
  abuse_concerns_children_other_details_page.submit_concern_details(
    concern_details: 'Description of safety concerns I have',
    behaviour_start: 'This started about a year ago',
    behaviour_stop: 'It stopped earlier this month',
    asked_for_help: false
  )
end

When(/^I submit that I don't have any safety concerns about myself$/) do
  abuse_concerns_applicant_info_page.click_continue_link

  expect(abuse_concerns_applicant_question_page).to be_fully_loaded
  abuse_concerns_applicant_question_page.submit_no

  expect(abuse_concerns_applicant_physical_page).to be_fully_loaded
  abuse_concerns_applicant_physical_page.submit_no

  expect(abuse_concerns_applicant_financial_page).to be_fully_loaded
  abuse_concerns_applicant_financial_page.submit_no

  expect(abuse_concerns_applicant_psychological_page).to be_fully_loaded
  abuse_concerns_applicant_psychological_page.submit_no

  expect(abuse_concerns_applicant_emotional_page).to be_fully_loaded
  abuse_concerns_applicant_emotional_page.submit_no

  expect(abuse_concerns_applicant_other_page).to be_fully_loaded
  abuse_concerns_applicant_other_page.submit_no

  expect(applicant_has_protection_court_order_page).to be_fully_loaded
  applicant_has_protection_court_order_page.submit_no

  expect(abuse_concerns_contact_page).to be_fully_loaded
  abuse_concerns_contact_page.submit_contact_details(
    contact_type: 'no',
    being_in_touch: 'no'
  )
end

And(/^I submit that I "(have|haven't)" been abused by the respondent$/) do |arg|
  abuse_concerns_applicant_info_page.click_continue_link

  expect(abuse_concerns_applicant_question_page).to be_fully_loaded

  if arg == "haven't"
    abuse_concerns_applicant_question_page.submit_no
    next
  end

  abuse_concerns_applicant_question_page.submit_yes

  expect(abuse_concerns_applicant_question_details_page).to be_fully_loaded
  abuse_concerns_applicant_question_details_page.submit_concern_details(
    concern_details: 'Description of sexual abuse',
    behaviour_start: 'Many years ago',
    behaviour_stop: 'About two years ago',
    asked_for_help: false
  )
end

And(/^I submit that I "(have|haven't)" been physically abused by the respondent$/) do |arg|
  expect(abuse_concerns_applicant_physical_page).to be_fully_loaded

  if arg == "haven't"
    abuse_concerns_applicant_physical_page.submit_no
    next
  end

  abuse_concerns_applicant_physical_page.submit_yes

  expect(abuse_concerns_applicant_physical_details_page).to be_fully_loaded
  abuse_concerns_applicant_physical_details_page.submit_concern_details(
    concern_details: 'The respondent hit me',
    behaviour_start: 'Many years ago',
    behaviour_stop: 'About two years ago',
    asked_for_help: false
  )
end

And(/^I submit that I "(have|haven't)" been financially abused by the respondent$/) do |arg|
  expect(abuse_concerns_applicant_financial_page).to be_fully_loaded

  if arg == "haven't"
    abuse_concerns_applicant_financial_page.submit_no
    next
  end

  abuse_concerns_applicant_financial_page.submit_yes

  expect(abuse_concerns_applicant_financial_details_page).to be_fully_loaded
  abuse_concerns_applicant_financial_details_page.submit_concern_details(
    concern_details: 'The respondent took my money',
    behaviour_start: 'Many years ago',
    behaviour_stop: 'About two years ago',
    asked_for_help: false
  )
end

And(/^I submit that I "(have|haven't)" been psychologically abused by the respondent$/) do |arg|
  expect(abuse_concerns_applicant_psychological_page).to be_fully_loaded

  if arg == "haven't"
    abuse_concerns_applicant_psychological_page.submit_no
    next
  end

  abuse_concerns_applicant_psychological_page.submit_yes

  expect(abuse_concerns_applicant_psychological_details_page).to be_fully_loaded
  abuse_concerns_applicant_psychological_details_page.submit_concern_details(
    concern_details: 'The respondent psychologically abused me',
    behaviour_start: 'Many years ago',
    behaviour_stop: 'About two years ago',
    asked_for_help: false
  )
end

And(/^I submit that I "(have|haven't)" been emotionally abused by the respondent$/) do |arg|
  expect(abuse_concerns_applicant_emotional_page).to be_fully_loaded

  if arg == "haven't"
    abuse_concerns_applicant_emotional_page.submit_no
    next
  end

  abuse_concerns_applicant_emotional_page.submit_yes

  expect(abuse_concerns_applicant_emotional_details_page).to be_fully_loaded
  abuse_concerns_applicant_emotional_details_page.submit_concern_details(
    concern_details: 'The respondent emotionally abused me',
    behaviour_start: 'Many years ago',
    behaviour_stop: 'About two years ago',
    asked_for_help: false
  )
end

And(/^I submit that I "(do|don't)" have any other concerns about my welfare$/) do |arg|
  expect(abuse_concerns_applicant_other_page).to be_fully_loaded

  if arg == "don't"
    abuse_concerns_applicant_other_page.submit_no
    next
  end

  abuse_concerns_applicant_other_page.submit_yes

  expect(abuse_concerns_applicant_other_details_page).to be_fully_loaded
  abuse_concerns_applicant_other_details_page.submit_concern_details(
    concern_details: 'Description of other abuse',
    behaviour_start: 'Many years ago',
    behaviour_stop: 'About two years ago',
    asked_for_help: false
  )
end

And(/^I submit that I "(have|haven't)" had or currently have court orders made for my protection$/) do |arg|
  answer = arg == 'have'

  expect(applicant_has_protection_court_order_page).to be_fully_loaded
  applicant_has_protection_court_order_page.submit(answer)
end

And(/^I submit that I "(do|don't)" agree to the children having contact with the other people in this application$/) do |arg|
  answer = arg == 'do' ? 'yes' : 'no'

  expect(abuse_concerns_contact_page).to be_fully_loaded
  abuse_concerns_contact_page.submit_contact_details(
    contact_type: answer,
    being_in_touch: answer
  )
end

Then(/^I should be taken to the applicant abuse concerns page$/) do
  expect(abuse_concerns_applicant_info_page).to be_fully_loaded
end
