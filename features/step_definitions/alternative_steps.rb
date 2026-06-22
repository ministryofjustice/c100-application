When(/^I submit that I understand the process of going to court$/) do
  expect(alternative_court_page).to be_displayed
  alternative_court_page.acknowledge_and_continue
end

When(/^I submit that I have tried all alternative ways to reach an agreement$/) do
  expect(alternative_page).to be_displayed
  alternative_page.click_continue_link

  expect(alternative_negotiation_page).to be_displayed
  alternative_negotiation_page.submit_yes

  expect(alternative_mediation_page).to be_displayed
  alternative_mediation_page.submit_yes

  expect(alternative_lawyer_page).to be_displayed
  alternative_lawyer_page.submit_yes

  expect(alternative_collaborative_law_page).to be_displayed
  alternative_collaborative_law_page.submit_yes
end

Then(/^I should be taken to the going to court page$/) do
  expect(alternative_court_page).to be_displayed
end
