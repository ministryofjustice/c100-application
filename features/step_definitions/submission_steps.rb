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

And(/^I submit the application with email "([^"]*)"$/) do |email|
  expect(submission_page).to be_displayed
  submission_page.submit_receipt_email(email)

  expect(submission_email_check_page).to be_displayed
  submission_email = submission_email_check_page.content.receipt_email.text
  expect(submission_email).to include(email)
  submission_email_check_page.submit_yes
end

And(/^I pay using Help With Fees with reference "([^"]*)"$/) do |reference|
  application_payment_page.pay_by_help_with_fees(reference)
end