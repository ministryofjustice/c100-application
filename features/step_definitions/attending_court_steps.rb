When(/^I submit the attending court details$/) do
  expect(attending_court_intermediary_page).to be_displayed
  attending_court_intermediary_page.submit_yes('Needed for the respondent')

  expect(attending_court_language_page).to be_displayed
  attending_court_language_page.submit_language_requirements(language_interpreter_details: 'German needed for respondent')

  expect(attending_court_special_arrangements_page).to be_displayed
  attending_court_special_arrangements_page.submit_special_arrangements(separate_waiting_rooms: true, special_arrangements_details: 'Please keep the time the kids are needed for to a minimum')

  expect(attending_court_special_assistance_page).to be_displayed
  attending_court_special_assistance_page.continue_without_filling
end

And(/^I submit the attending court details with safety arrangements$/) do
  expect(attending_court_intermediary_page).to be_displayed
  attending_court_intermediary_page.submit_yes('I need someone to communicate between me and the respondent')

  expect(attending_court_language_page).to be_displayed
  attending_court_language_page.submit_language_requirements(welsh_language_details: 'Needed for Jake Gyllenhaal')

  expect(attending_court_special_arrangements_page).to be_displayed
  attending_court_special_arrangements_page.submit_special_arrangements(separate_waiting_rooms: true, separate_entrance_exit: true)

  expect(attending_court_special_assistance_page).to be_displayed
  attending_court_special_assistance_page.continue_without_filling
end

When(/^I submit that I have no issues attending court$/) do
  expect(attending_court_intermediary_page).to be_displayed
  attending_court_intermediary_page.submit_no

  expect(attending_court_language_page).to be_displayed
  attending_court_language_page.continue_without_filling

  expect(attending_court_special_arrangements_page).to be_displayed
  attending_court_special_arrangements_page.continue_without_filling
end

And(/^I submit that I don't require special assistance when attending court$/) do
  expect(attending_court_special_assistance_page).to be_displayed
  attending_court_special_assistance_page.continue_without_filling
end

And(/^I submit that I require special assistance when attending court: "(.*)"$/) do |arg|
  expect(attending_court_special_assistance_page).to be_displayed
  attending_court_special_assistance_page.submit_special_assistance(
    special_assistance_details: arg
  )
end

Then(/^I should be taken to the attending court page$/) do
  expect(attending_court_intermediary_page).to be_displayed
end