Then(/^I should see the “Sorry, you cannot apply online” page$/) do
  expect(no_court_page.content).to have_header
end