Then(/^I should see the complete “Where do the children live\?” page$/) do
  expect(postcode_page.content).to have_header
  expect(postcode_page.content).to have_entry
  expect(postcode_page.content).to have_dropdown
end

Given(/^I am on the “Where do the children live\?” page$/) do
  postcode_page.load_page
end

When(/^I click the “If you do not know where the children live” dropdown$/) do
  postcode_page.content.dropdown.click
end

Then(/^I should see the dropdown text$/) do
  expect(postcode_page.content).to have_dropdown_text
end

Then(/^I should see a full postcode error message$/) do
  expect(postcode_page.content).to have_error
  expect(postcode_page.content).to have_error_title
  expect(postcode_page.content).to have_error_message
end


Then(/^I should see the invalid postcode error message$/) do
  expect(postcode_page.content).to have_error_invalid
  expect(postcode_page.content).to have_error_title
  expect(postcode_page.content).to have_error_message_invalid
end
