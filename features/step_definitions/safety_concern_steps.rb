When(/^I submit that I have no safety concerns about the children$/) do
  safety_concern_page.click_continue_link

  expect(safety_concern_abduction_page).to be_fully_loaded
  safety_concern_abduction_page.submit_no

  expect(safety_concern_substance_page).to be_fully_loaded
  safety_concern_substance_page.submit_no

  expect(safety_concern_abuse_page).to be_fully_loaded
  safety_concern_abuse_page.submit_no

  expect(safety_concern_domestic_page).to be_fully_loaded
  safety_concern_domestic_page.submit_no

  expect(safety_concern_other_page).to be_fully_loaded
  safety_concern_other_page.submit_no
end

When(/^I submit that I "(do|don't)" have abduction concerns about the children$/) do |arg|
  safety_concern_page.click_continue_link
  
  expect(safety_concern_abduction_page).to be_fully_loaded

  if arg == "don't"
    safety_concern_abduction_page.submit_no
    next
  end

  safety_concern_abduction_page.submit_yes

  expect(abduction_international_page).to be_fully_loaded
  abduction_international_page.submit_yes

  expect(abduction_children_have_passport_page).to be_fully_loaded
  abduction_children_have_passport_page.submit_yes

  expect(abduction_passport_details_page).to be_fully_loaded
  abduction_passport_details_page.select_no_multiple_passports
  abduction_passport_details_page.select_passport_possession('mother')
  abduction_passport_details_page.click_continue_button

  expect(abduction_previous_attempt_page).to be_fully_loaded
  abduction_previous_attempt_page.submit_no

  expect(abduction_risk_details_page).to be_fully_loaded
  abduction_risk_details_page.submit_risk_details(
    'They might be taken by their other parent', 
    'The children are with me'
  )
end

And(/^I submit that I "(do|don't)" have concerns about drug, alcohol or substance abuse$/) do |arg|
  expect(safety_concern_substance_page).to be_fully_loaded

  if arg == 'do'
    safety_concern_substance_page.submit_yes('Alcoholic and drug abuse details')
  else
    safety_concern_substance_page.submit_no
  end
end

And(/^I submit that I "(do|don't)" have domestic abuse or child concerns about the children$/) do |arg|
  answer = arg == 'do'

  expect(safety_concern_abuse_page).to be_fully_loaded
  safety_concern_abuse_page.submit(answer)
end

Then(/^I should be taken to the safety concerns page$/) do
  expect(safety_concern_page).to be_fully_loaded
end
