Then("I am on the Cookie management page") do
  expect(cookie_management_page.content).to have_header
end

Then(/^the analytics cookies radio buttons are defaulted to '([^']*)'$/) do |expected_value|
  expect(page).to have_checked_field(expected_value, visible: :all)
end

And(/^analytics cookies are NOT allowed to be set$/) do
  expect(page.evaluate_script("window['ga-disable-#{Rails.application.config.x.analytics_tracking_id}']"))
    .to be(true), 'Google analytics is enabled it should not be'
end

When(/^I select '([^']*)' for analytics cookies$/) do |value|
  choose(value, allow_label_click: true)
end

When(/^I click the Save cookie settings button$/) do
  cookie_management_page.click_save_cookie_settings
end

Then(/^google analytics cookies are allowed to be set$/) do
  expect(cookie_management_page).to have_google_analytics_enabled
end

And(/^I see the confirmation message$/) do
  expect(cookie_management_page).to have_notification_banner
end