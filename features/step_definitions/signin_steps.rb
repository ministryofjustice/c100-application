Then(/^I should be redirected to “Sign in”$/) do
  expect(signin_page.content).to have_header
end