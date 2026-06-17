When(/^I submit that I "(do|don't)" have a solicitor$/) do |arg|
  expect(applicant_has_solicitor_page).to be_displayed

  if arg == 'do'
    applicant_has_solicitor_page.submit_yes
  else
    applicant_has_solicitor_page.submit_no
  end
end

When(/^I submit the solicitor details$/) do
  expect(applicant_has_solicitor_page).to be_displayed
  applicant_has_solicitor_page.submit_yes

  expect(solicitor_personal_details_page).to be_displayed
  solicitor_personal_details_page.submit_solicitor_details(
    full_name: 'Annalise Keating',
    firm_name: 'Keating Law Firm')

  expect(solicitor_address_details_page).to be_displayed
  solicitor_address_details_page.submit_address_details(
    address_line_1: 'Windsor Castle',
    town: 'Windsor',
    country: 'United Kingdom',
    postcode: 'SL4 1QF'
  )

  expect(solicitor_contact_details_page).to be_displayed
  solicitor_contact_details_page.submit_contact_details(
    email: 'annalise@law.com',
    phone: '00000000000',
    dx_number: '00000000000'
  )
end

Then(/^I should be taken to the solicitor details page$/) do
  expect(applicant_has_solicitor_page).to be_displayed
end