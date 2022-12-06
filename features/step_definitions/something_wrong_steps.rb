Given(/^I am on the “Something went wrong” page$/) do
  something_wrong_page.load_page
end

Then(/^I should see the complete “Something went wrong” page$/) do
  expect(something_wrong_page.content).to have_header
  expect(something_wrong_page.content).to have_p1
  expect(something_wrong_page.content).to have_subtitle
  expect(something_wrong_page.content).to have_p2
  expect(something_wrong_page.content).to have_link('Download the form (PDF', href: 'https://formfinder.hmctsformfinder.justice.gov.uk/c100-eng.pdf')
end