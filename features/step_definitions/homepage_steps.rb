When(/^I open the home page$/) do
  home_page.load_page
  expect(home_page.content).to have_header
end

Then(/^I should see the home page$/) do
  expect(home_page.content).to have_needs
end

When(/^I click the continue button$/) do
  home_page.content.continue.click
end

When(/^I click “Or return to a saved application”$/) do
  home_page.content.sign_in.click
end

When(/^I click the back button$/) do
  click_link(href: 'https://www.gov.uk/looking-after-children-divorce/apply-for-court-order')
end

Then(/^I am redirected to “Making child arrangements if you divorce or separate”$/) do
  expect(page).to have_link('', href: 'https://apply-to-court-about-child-arrangements.service.justice.gov.uk/')
end

When(/^I click the “Certificate of suitability” link$/) do
  click_link(href: 'https://www.gov.uk/government/publications/form-fp9-certificate-of-suitability-of-litigation-friend')
end

And(/^I wait for a long time$/) do
  home_page.slow_continue
end