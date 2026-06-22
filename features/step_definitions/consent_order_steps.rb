When(/^I submit that I have a Consent Order with a child protection case$/) do
  expect(consent_order_page).to be_displayed
  consent_order_page.submit_existing_consent_order

  file_path = File.absolute_path('features/support/sample_file/image.jpg')
  upload_consent_order_page.upload_file(file_path)

  child_protection_info_page.click_continue_link

  expect(child_protection_case_page).to be_displayed
  child_protection_case_page.submit_yes
end

When(/^I navigate back to the consent order page$/) do
  expect(safety_concern_page).to be_displayed
  safety_concern_page.click_back_link

  expect(child_protection_info_page).to be_displayed
  child_protection_info_page.click_back_link

  expect(child_protection_case_page).to be_displayed
  child_protection_case_page.click_back_link
end

Then(/^I should be on the consent order page$/) do
  expect(consent_order_page).to be_displayed
end

And(/^I submit the consent order form with an existing consent order$/) do
  consent_order_page.submit_existing_consent_order
end

And(/^I submit the consent order form without an existing consent order$/) do
  consent_order_page.submit_without_consent_order
end
