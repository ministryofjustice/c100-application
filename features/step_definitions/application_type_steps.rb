Then(/^I should see the “What kind of application do you want to make\?” page$/) do
  expect(application_type_page.content).to have_header
end