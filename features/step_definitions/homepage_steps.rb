When(/^I open the home page$/) do
  home_page.load_page
  expect(home_page.content).to have_header
end

Then(/^I should see the home page$/) do
  expect(home_page.content).to have_needs
  expect(home_page.content).to have_continue
  expect(home_page.content).to have_sign_in
end

Then(/^I am redirected to “Making child arrangements if you divorce or separate”$/) do
  expect(page).to have_link('', href: 'https://apply-to-court-about-child-arrangements.service.justice.gov.uk/')
end