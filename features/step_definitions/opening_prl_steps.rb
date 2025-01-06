Then(/^I should not see the save draft button$/) do
  expect(page).not_to have_selector(:button, 'Save and come back later')
end

Then(/^I should see the save draft button$/) do
  expect(page).to have_selector(:button, 'Save and come back later')
end

When(/^step has focus/) do
  expect(page.evaluate_script("document.activeElement.id")).to eq('steps-opening-start-or-continue-form-children-postcode-field-error')
end

When(/^I click the continue button with an invalid postcode$/) do
  RSpec::Mocks.with_temporary_scope do
    C100App::CourtfinderAPI.any_instance.stub(:court_for).and_return({"courts"=>[]})

    find_button("Continue").click
  end
end

Given("I stub fact api call") do
  WebMock.enable!
  WebMock.allow_net_connect!
  WebMock::API.stub_request(:get, "https://www.find-court-tribunal.service.gov.uk/v2/proxy/search/postcode/TQ121XX/serviceArea/childcare-arrangements").
    to_return(status: 200, body: "{}", headers: {})

  WebMock::API.stub_request(:get, "https://www.find-court-tribunal.service.gov.uk/health").
    to_return(status: 200, body: "{\"mapit-api\":{\"status\":\"UP\"}}", headers: {})
end
