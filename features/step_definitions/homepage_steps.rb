When(/^I open the home page$/) do
  home_page.load_page
  expect(home_page.content).to have_header
end

Then(/^I should see the home page$/) do
  expect(home_page.content).to have_needs
  expect(home_page.content).to have_continue
  expect(home_page.content).to have_sign_in
end

When(/^I click the continue button$/) do
  begin
    click_button('Continue')
  rescue
    click_link('Continue')
  end
end

When(/^I click “Or return to a saved application”$/) do
  home_page.content.sign_in.click
end

When(/^I click the back button$/) do
  click_link('Back')
end

Then(/^I am redirected to “Making child arrangements if you divorce or separate”$/) do
  expect(page).to have_link('', href: 'https://apply-to-court-about-child-arrangements.service.justice.gov.uk/')
end

And(/^I wait for a long time$/) do
  home_page.slow_continue
end