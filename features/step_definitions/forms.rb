# Everything that has to do with forms, like radios, check boxes or inputs
include ActiveSupport::Testing::TimeHelpers

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  find(:xpath, './/main//form', visible: true, wait: true)
  fill_in(field, with: value)
rescue Selenium::WebDriver::Error::UnknownError => e
  find(:xpath, './/main//form', visible: true, wait: true)
  fill_in(field, with: value)
end

And(/^I check "([^"]*)"$/) do |text|
  find(:xpath, './/main//form', visible: true, wait: true)
  check(text, allow_label_click: true)
rescue Selenium::WebDriver::Error::UnknownError => e
  find(:xpath, './/main//form', visible: true, wait: true)
  find('label', text: text).click
end

When(/^I click the radio button "([^"]*)"$/) do |text|
  find(:xpath, './/main//form', visible: true, wait: true)
  find('label', text: text).click
end

Then(/^I click "([^"]*)" for the radio button "([^"]*)"$/) do |text, legend|
  find(
    'legend > span', text: legend
  ).ancestor(
    'fieldset', order: :reverse, match: :first
  ).find(
    'label', text: text
  ).click
end

When(/^I choose "([^"]*)"$/) do |text|
  find(:xpath, './/main//form', visible: true, wait: true)
  step %[I click the radio button "#{text}"]
  find_button('Continue').click
end

And(/^I choose "([^"]*)" and fill in "([^"]*)" with "([^"]*)"$/) do |text, field, value|
  step %[I click the radio button "#{text}"]
  step %[I fill in "#{field}" with "#{value}"]
  find_button('Continue').click
end

When(/^I enter the date (\d+)\-(\d+)\-(\d+)$/) do |day, month, year|
  step %[I fill in "Day" with "#{day}"]
  step %[I fill in "Month" with "#{month}"]
  step %[I fill in "Year" with "#{year}"]
end

# For children sub form on safety concerns
Then(/^I submit the form details for "([^"]*)"$/) do |heading|
  step %[I should see "#{heading}"]
  step %[I fill in "Briefly describe what happened and who was involved, if you feel able to" with "Information..."]

  step %[I fill in "When did this behaviour start?" with "2 weeks ago"]

  step %[I click "No" for the radio button "Is the behaviour still ongoing?"]
  step %[I fill in "When did the behaviour stop?" with "1 weeks ago"]

  step %[I click "Yes" for the radio button "Have you ever asked for help?"]
  step %[I fill in "Who did you ask for help?" with "Friend"]

  step %[I click "Yes" for the radio button "Did they help you?"]
  step %[I fill in "What did they do?" with "Information..."]

  step %[I click the "Continue" button]
end

# Needed for the children journey
When(/^I have selected orders for the court to decide$/) do
  step %[I visit "steps/petition/orders"]
  step %[I check "Decide who they live with and when"]
  step %[I check "Decide how much time they spend with each person"]
  step %[I click the "Continue" button]
  step %[I should see "Decide how much time they spend with each person"]
  step %[I should see "This is known as a Child Arrangements Order"]
end

# Needed for the applicant and respondent journeys
When(/^I have entered a child with first name "([^"]*)" and last name "([^"]*)"$/) do |first_name, last_name|
  step %[I visit "steps/children/names"]
  step %[I fill in "First name(s)" with "#{first_name}"]
  step %[I fill in "Last name(s)" with "#{last_name}"]
  step %[I click the "Continue" button]
  step %[I should see "Provide details for #{first_name} #{last_name}"]
end

And(/^I choose "([^"]*)" for all options on this page$/) do |arg|
  options = page.all('label', text: arg)
  options.each do |radio_button|
    radio_button.click
  end
  find_button('Continue').click
end

And(/^I choose "([^"]*)" for all options on this page without continuing$/) do |arg|
  options = page.all('label', text: arg)
  options.each do |radio_button|
    radio_button.click
  end
end

And(/^I fill in the Expiry date with a valid card expiry date$/) do
  future = travel 365.day
  step %[I fill in "Month" with "#{future.month}"]
  step %[I fill in "Year" with "#{future.year}"]
end

When(/^I specify they are "(\d+)" years of age$/) do |age|
  today = Date.today
  date_of_birth = today - age.to_i.years

  step %[I fill in "Day" with "#{date_of_birth.day}"]
  step %[I fill in "Month" with "#{date_of_birth.month}"]
  step %[I fill in "Year" with "#{date_of_birth.year}"]
end
