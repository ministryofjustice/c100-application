When(/^I submit the international issues details$/) do
  expect(international_resident_page).to be_displayed
  international_resident_page.submit_no

  expect(international_jurisdiction_page).to be_displayed
  international_jurisdiction_page.submit_yes('Details')

  expect(international_request_page).to be_displayed
  international_request_page.submit_no
end

When(/^I submit the international issues details with an international resident$/) do
  expect(international_resident_page).to be_displayed
  international_resident_page.submit_yes("Emily's maternal grandparents are in Austria")

  expect(international_jurisdiction_page).to be_displayed
  international_jurisdiction_page.submit_no

  expect(international_request_page).to be_displayed
  international_request_page.submit_no
end

When(/^I submit that there isn't any international issues in this application$/) do
  expect(international_resident_page).to be_displayed
  international_resident_page.submit_no

  expect(international_jurisdiction_page).to be_displayed
  international_jurisdiction_page.submit_no

  expect(international_request_page).to be_displayed
  international_request_page.submit_no
end

Then(/^I should be taken to the international resident page$/) do
  expect(international_resident_page).to be_displayed
end
