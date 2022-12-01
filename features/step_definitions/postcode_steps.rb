Then(/^I should see the complete “Where do the children live\?” page$/) do
  expect(postcode_page.content).to have_header
end