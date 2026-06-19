When(/^I submit my reason for the application as "([^"]*)"$/) do |reason|
  expect(application_details_page).to be_displayed
  application_details_page.submit_details(reason)
end

When(/^I submit that there "(are|aren't)" factors that may affect any adult in this application taking part in the court proceedings$/) do |arg|
  answer = arg == 'are'

  expect(litigation_capacity_page).to be_displayed
  litigation_capacity_page.submit(answer)
end

And(/^I submit that there "(are|aren't)" factors affecting ability to participate$/) do |arg|
  expect(litigation_capacity_details_page).to be_displayed
  litigation_capacity_details_page.continue_without_filling if arg == "aren't"
end

When(/^I submit the application with email "([^"]*)"$/) do |email|
  expect(submission_page).to be_displayed
  submission_page.submit_receipt_email(email)

  expect(submission_email_check_page).to be_displayed
  expect(submission_email_check_page.displayed_email).to include(email)
  submission_email_check_page.submit_yes
end

And(/^I pay using Help With Fees with reference "([^"]*)"$/) do |reference|
  application_payment_page.pay_by_help_with_fees(reference)
end

Then(/^I should be taken to the reason for application page$/) do
  expect(application_details_page).to be_displayed
end

Then(/^I should be taken to the litigation capacity page$/) do
  expect(litigation_capacity_page).to be_displayed
end

Then(/^I should be taken to the application submission page$/) do
  expect(submission_page).to be_displayed
end
