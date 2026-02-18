include ActiveSupport::Testing::TimeHelpers

# General and frequently used navigation steps, handling of links and page expectations
#
When(/^I visit "([^"]*)"$/) do |path|
  visit path
end

Then(/^I should be on "([^"]*)"$/) do |page_name|
  expect("#{Capybara.app_host}#{URI.parse(current_url).path}").to eql("#{Capybara.app_host}#{page_name}")
end

Then(/^I should see "([^"]*)"$/) do |text|
  find(:xpath, './/main', visible: true, wait: true)
  expect(page).to have_text(text)

rescue Selenium::WebDriver::Error::UnknownError => e
  find(:xpath, './/main', visible: true, wait: true)
  expect(page).to have_text(text)
end

Then(/^I should not see "([^"]*)"$/) do |text|
  expect(page).not_to have_text(text)
end

Then(/^I should see a "([^"]*)" link to "([^"]*)"$/) do |text, href|
  find(:xpath, './/main', visible: true, wait: true)
  expect(page).to have_link(text, href: href)
rescue Selenium::WebDriver::Error::UnknownError => e
  find(:xpath, './/main', visible: true, wait: true)
  expect(page).to have_link(text, href: href)
end

Then(/^I should see the save draft button$/) do
  expect(page).to have_selector(:button, 'Save and come back later')
end

Then(/^I should not see the save draft button$/) do
  expect(page).not_to have_selector(:button, 'Save and come back later')
end

When(/^I click the "([^"]*)" link$/) do |text|
  binding.pry if text == 'Back'
  puts 'AAAAAAAA'
  puts find('.govuk-back-link')[:href]
  find(:xpath, './/main', visible: true, wait: true)
  find(:css, 'a', text: text).click
rescue Selenium::WebDriver::Error::UnknownError => e
  find(:xpath, './/main', visible: true, wait: true)
  click_link(text)
end

When(/^I open the "([^"]*)" summary details$/) do |text|
  find('details > summary > span', text: text).click
end

When(/^I click the "([^"]*)" button$/) do |text|
  expect(page).to have_button("#{text}")
  find_button("#{text}").click
rescue Selenium::WebDriver::Error::UnknownError => e
  find_button("#{text}").click
end

When(/^I wait and click the "([^"]*)" button$/) do |text|
  travel_to 61.minutes.from_now
  begin
    find_button("#{text}").click
  rescue
    click_link(text)
  end
end

Then('the time goes back to normal') do
  travel_back
end

When(/^I click the postcode page "([^"]*)" button$/) do |text|
  RSpec::Mocks.with_temporary_scope do
    stub_resp = {
      "slug"=>"childcare-arrangements",
      "name"=>"Childcare arrangements if you separate from your partner",
      "onlineText"=>nil,
      "onlineUrl"=>"https://apply-to-court-about-child-arrangements.service.justice.gov.uk/",
      "courts"=>[{"name"=>"Coventry Combined Court Centre",
                  "slug"=>"coventry-combined-court-centre",
                  "distance"=>10.6,
                  "areasOfLawSpoe"=>["Children"]}]
    }
    court_lookup_resp = {"name"=>"Coventry Combined Court Centre", "slug"=>"coventry-combined-court-centre", "info"=>"<p><a href=https://www.gov.uk/government/news/scammers-using-hmcts-telephone-numbers>Scammers are mimicking genuine HMCTS phone numbers and email addresses</a>. They may demand payment and claim to be from HMRC or enforcement. If you're unsure, do not pay anything and report the scam to <a href=https://www.actionfraud.police.uk/>Action Fraud</a>.</p>", "open"=>true, "directions"=>nil, "image_file"=>"coventry_combined_court_centre.jpg", "lat"=>52.4055836530515, "lon"=>-1.50643963844351, "urgent_message"=>"", "crown_location_code"=>417, "family_location_code"=>180, "magistrates_location_code"=>nil, "tribunal_location_code"=>nil, "areas_of_law"=>[{"name"=>"Adoption", "external_link"=>"https://www.gov.uk/child-adoption", "display_url"=>nil, "external_link_desc"=>"Information about adopting a child", "display_name"=>nil, "display_external_link"=>"https://www.gov.uk/child-adoption/applying-for-an-adoption-court-order"}, {"name"=>"Bankruptcy", "external_link"=>"https://www.gov.uk/apply-for-bankruptcy", "display_url"=>nil, "external_link_desc"=>"Information about applying for bankruptcy", "display_name"=>nil, "display_external_link"=>"https://www.gov.uk/bankruptcy"}, {"name"=>"Children", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>"Childcare arrangements if you separate from your partner", "display_external_link"=>"https://www.gov.uk/looking-after-children-divorce"}, {"name"=>"Crime", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>nil, "display_external_link"=>nil}, {"name"=>"Divorce", "external_link"=>"https://www.gov.uk/divorce", "display_url"=>nil, "external_link_desc"=>"Information about getting a divorce", "display_name"=>"Divorce hearings", "display_external_link"=>nil}, {"name"=>"Domestic violence", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>"Domestic abuse", "display_external_link"=>"https://www.gov.uk/injunction-domestic-violence"}, {"name"=>"High Court District Registry", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>"High Court cases – serious or high profile criminal or civil law cases", "display_external_link"=>nil}, {"name"=>"Housing possession", "external_link"=>"https://www.gov.uk/evicting-tenants", "display_url"=>nil, "external_link_desc"=>"Information about evicting tenants", "display_name"=>"Housing", "display_external_link"=>nil}, {"name"=>"Money claims", "external_link"=>"https://www.gov.uk/make-court-claim-for-money", "display_url"=>nil, "external_link_desc"=>"Information about making a court claim for money", "display_name"=>nil, "display_external_link"=>nil}, {"name"=>"Single justice procedure", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>nil, "display_external_link"=>nil}], "types"=>["Family Court", "County Court", "Crown Court"], "emails"=>[{"address"=>"warwickcrowncourt@justice.gov.uk", "description"=>"Crown court", "explanation"=>nil}, {"address"=>"bailiffs.coventry.countycourt@justice.gov.uk", "description"=>"Enforcement", "explanation"=>nil}, {"address"=>"civilenquiries.coventry.countycourt@justice.gov.uk", "description"=>"County court", "explanation"=>"Civil enquiries"}, {"address"=>"Civilhearings.coventry.countycourt@justice.gov.uk", "description"=>"Listing", "explanation"=>nil}, {"address"=>"coventry.breathingspace@justice.gov.uk", "description"=>"Breathing space enquiries", "explanation"=>""}, {"address"=>"divorce.coventry.countycourt@justice.gov.uk", "description"=>"Family court", "explanation"=>nil}, {"address"=>"children.coventry.countycourt@justice.gov.uk", "description"=>"Family public law (children in care)", "explanation"=>"Paper process"}, {"address"=>"contactfpl@justice.gov.uk", "description"=>"Family public law (children in care)", "explanation"=>"Digital process for case numbers starting with C5"}, {"address"=>"coventryprivatelawapplications@justice.gov.uk", "description"=>"Applications", "explanation"=>"C100 applications"}], "contacts"=>[{"number"=>"0300 332 1000", "description"=>"Enquiries", "explanation"=>"Witness Services enquiries"}, {"number"=>"0300 123 5577", "description"=>"County court", "explanation"=>""}, {"number"=>"0247 653 6322", "description"=>"Counter appointments", "explanation"=>""}, {"number"=>"01926 429 133", "description"=>"Crown court", "explanation"=>""}, {"number"=>"0330 808 4424", "description"=>"Family public law (children in care)", "explanation"=>"Digital process for case numbers starting with C5"}, {"number"=>"01264 347 973", "description"=>"Fax", "explanation"=>""}], "opening_times"=>[{"description"=>"Counter service by appointment only", "hours"=>"Monday to Friday 10am to 2pm", "description_cy"=>nil}, {"description"=>"Telephone enquiries answered", "hours"=>"Monday to Friday 8:30am to 5pm", "description_cy"=>nil}, {"description"=>"Court open", "hours"=>"Monday to Friday 9am to 5pm", "description_cy"=>nil}], "application_updates"=>[], "facilities"=>[{"description"=>"This building has level access to the building entrance, and court room.\r\n ", "name"=>"Disabled access", "order"=>2}, {"description"=>"Assistance dogs are welcome.", "name"=>"Assistance dogs", "order"=>4}, {"description"=>"The building has hearing enhancement facilities available by prior arrangement.  Please contact the Court office by telephone or email if necessary.", "name"=>"Hearing Loop", "order"=>5}, {"description"=>"Refreshments are available via Vending Machine.", "name"=>"Refreshments", "order"=>11}, {"description"=>"4 interview rooms are available on the ground floor", "name"=>"Interview room", "order"=>12}, {"description"=>"This Court has a childrens room facility.", "name"=>"Children's waiting room", "order"=>14}, {"description"=>"Baby changing facilities are available in the disabled toilets on the ground floor\r\n ", "name"=>"Baby changing facility", "order"=>15}, {"description"=>"Court/hearing room video conferencing facilities and prison to court video link facilities are available by prior arrangement.Please contact the Court administration to check availability.\r\n \r\n.\r\n ", "name"=>"Video facilities", "order"=>17}, {"description"=>" \r\nSupport for witnesses is available from the <a href=\"https://www.citizensadvice.org.uk/\" rel=\"nofollow\">Citizens Advice</a> witness service. Support Through Court is available on Mondays to provide assistance.", "name"=>"Witness service", "order"=>19}], "addresses"=>[{"address_lines"=>["140 Much Park Street"], "postcode"=>"CV1 2SN", "town"=>"Coventry", "type"=>"Visit or contact us", "county"=>"Warwickshire", "description"=>nil, "fields_of_law"=>nil}], "gbs"=>"Y260", "dx_number"=>["701580 Coventry 5"], "service_area"=>[], "in_person"=>true, "access_scheme"=>true, "additional_links"=>[{"url"=>"https://www.gov.uk/guidance/debt-respite-breathing-space-scheme-creditors-responsibilities-to-the-court", "description"=>"Breathing Space"}], "common_flag"=>false, "service_centre"=>{"is_a_service_centre"=>false, "intro_paragraph"=>"", "intro_paragraph_cy"=>""}}
    C100App::CourtfinderAPI.any_instance.stub(:court_for).and_return(stub_resp)
    C100App::CourtfinderAPI.any_instance.stub(:court_lookup).and_return(court_lookup_resp)
    find_button("#{text}").click
  end
end

When(/^I wait and click the postcode page "([^"]*)" button$/) do |text|
  travel 61.minutes do
    RSpec::Mocks.with_temporary_scope do
      stub_resp = {
        "slug"=>"childcare-arrangements",
        "name"=>"Childcare arrangements if you separate from your partner",
        "onlineText"=>nil,
        "onlineUrl"=>"https://apply-to-court-about-child-arrangements.service.justice.gov.uk/",
        "courts"=>[{"name"=>"Coventry Combined Court Centre",
                    "slug"=>"coventry-combined-court-centre",
                    "distance"=>10.6,
                    "areasOfLawSpoe"=>["Children"]}]
      }
      court_lookup_resp = {"name"=>"Coventry Combined Court Centre", "slug"=>"coventry-combined-court-centre", "info"=>"<p><a href=https://www.gov.uk/government/news/scammers-using-hmcts-telephone-numbers>Scammers are mimicking genuine HMCTS phone numbers and email addresses</a>. They may demand payment and claim to be from HMRC or enforcement. If you're unsure, do not pay anything and report the scam to <a href=https://www.actionfraud.police.uk/>Action Fraud</a>.</p>", "open"=>true, "directions"=>nil, "image_file"=>"coventry_combined_court_centre.jpg", "lat"=>52.4055836530515, "lon"=>-1.50643963844351, "urgent_message"=>"", "crown_location_code"=>417, "family_location_code"=>180, "magistrates_location_code"=>nil, "tribunal_location_code"=>nil, "areas_of_law"=>[{"name"=>"Adoption", "external_link"=>"https://www.gov.uk/child-adoption", "display_url"=>nil, "external_link_desc"=>"Information about adopting a child", "display_name"=>nil, "display_external_link"=>"https://www.gov.uk/child-adoption/applying-for-an-adoption-court-order"}, {"name"=>"Bankruptcy", "external_link"=>"https://www.gov.uk/apply-for-bankruptcy", "display_url"=>nil, "external_link_desc"=>"Information about applying for bankruptcy", "display_name"=>nil, "display_external_link"=>"https://www.gov.uk/bankruptcy"}, {"name"=>"Children", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>"Childcare arrangements if you separate from your partner", "display_external_link"=>"https://www.gov.uk/looking-after-children-divorce"}, {"name"=>"Crime", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>nil, "display_external_link"=>nil}, {"name"=>"Divorce", "external_link"=>"https://www.gov.uk/divorce", "display_url"=>nil, "external_link_desc"=>"Information about getting a divorce", "display_name"=>"Divorce hearings", "display_external_link"=>nil}, {"name"=>"Domestic violence", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>"Domestic abuse", "display_external_link"=>"https://www.gov.uk/injunction-domestic-violence"}, {"name"=>"High Court District Registry", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>"High Court cases – serious or high profile criminal or civil law cases", "display_external_link"=>nil}, {"name"=>"Housing possession", "external_link"=>"https://www.gov.uk/evicting-tenants", "display_url"=>nil, "external_link_desc"=>"Information about evicting tenants", "display_name"=>"Housing", "display_external_link"=>nil}, {"name"=>"Money claims", "external_link"=>"https://www.gov.uk/make-court-claim-for-money", "display_url"=>nil, "external_link_desc"=>"Information about making a court claim for money", "display_name"=>nil, "display_external_link"=>nil}, {"name"=>"Single justice procedure", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>nil, "display_external_link"=>nil}], "types"=>["Family Court", "County Court", "Crown Court"], "emails"=>[{"address"=>"warwickcrowncourt@justice.gov.uk", "description"=>"Crown court", "explanation"=>nil}, {"address"=>"bailiffs.coventry.countycourt@justice.gov.uk", "description"=>"Enforcement", "explanation"=>nil}, {"address"=>"civilenquiries.coventry.countycourt@justice.gov.uk", "description"=>"County court", "explanation"=>"Civil enquiries"}, {"address"=>"Civilhearings.coventry.countycourt@justice.gov.uk", "description"=>"Listing", "explanation"=>nil}, {"address"=>"coventry.breathingspace@justice.gov.uk", "description"=>"Breathing space enquiries", "explanation"=>""}, {"address"=>"divorce.coventry.countycourt@justice.gov.uk", "description"=>"Family court", "explanation"=>nil}, {"address"=>"children.coventry.countycourt@justice.gov.uk", "description"=>"Family public law (children in care)", "explanation"=>"Paper process"}, {"address"=>"contactfpl@justice.gov.uk", "description"=>"Family public law (children in care)", "explanation"=>"Digital process for case numbers starting with C5"}, {"address"=>"coventryprivatelawapplications@justice.gov.uk", "description"=>"Applications", "explanation"=>"C100 applications"}], "contacts"=>[{"number"=>"0300 332 1000", "description"=>"Enquiries", "explanation"=>"Witness Services enquiries"}, {"number"=>"0300 123 5577", "description"=>"County court", "explanation"=>""}, {"number"=>"0247 653 6322", "description"=>"Counter appointments", "explanation"=>""}, {"number"=>"01926 429 133", "description"=>"Crown court", "explanation"=>""}, {"number"=>"0330 808 4424", "description"=>"Family public law (children in care)", "explanation"=>"Digital process for case numbers starting with C5"}, {"number"=>"01264 347 973", "description"=>"Fax", "explanation"=>""}], "opening_times"=>[{"description"=>"Counter service by appointment only", "hours"=>"Monday to Friday 10am to 2pm", "description_cy"=>nil}, {"description"=>"Telephone enquiries answered", "hours"=>"Monday to Friday 8:30am to 5pm", "description_cy"=>nil}, {"description"=>"Court open", "hours"=>"Monday to Friday 9am to 5pm", "description_cy"=>nil}], "application_updates"=>[], "facilities"=>[{"description"=>"This building has level access to the building entrance, and court room.\r\n ", "name"=>"Disabled access", "order"=>2}, {"description"=>"Assistance dogs are welcome.", "name"=>"Assistance dogs", "order"=>4}, {"description"=>"The building has hearing enhancement facilities available by prior arrangement.  Please contact the Court office by telephone or email if necessary.", "name"=>"Hearing Loop", "order"=>5}, {"description"=>"Refreshments are available via Vending Machine.", "name"=>"Refreshments", "order"=>11}, {"description"=>"4 interview rooms are available on the ground floor", "name"=>"Interview room", "order"=>12}, {"description"=>"This Court has a childrens room facility.", "name"=>"Children's waiting room", "order"=>14}, {"description"=>"Baby changing facilities are available in the disabled toilets on the ground floor\r\n ", "name"=>"Baby changing facility", "order"=>15}, {"description"=>"Court/hearing room video conferencing facilities and prison to court video link facilities are available by prior arrangement.Please contact the Court administration to check availability.\r\n \r\n.\r\n ", "name"=>"Video facilities", "order"=>17}, {"description"=>" \r\nSupport for witnesses is available from the <a href=\"https://www.citizensadvice.org.uk/\" rel=\"nofollow\">Citizens Advice</a> witness service. Support Through Court is available on Mondays to provide assistance.", "name"=>"Witness service", "order"=>19}], "addresses"=>[{"address_lines"=>["140 Much Park Street"], "postcode"=>"CV1 2SN", "town"=>"Coventry", "type"=>"Visit or contact us", "county"=>"Warwickshire", "description"=>nil, "fields_of_law"=>nil}], "gbs"=>"Y260", "dx_number"=>["701580 Coventry 5"], "service_area"=>[], "in_person"=>true, "access_scheme"=>true, "additional_links"=>[{"url"=>"https://www.gov.uk/guidance/debt-respite-breathing-space-scheme-creditors-responsibilities-to-the-court", "description"=>"Breathing Space"}], "common_flag"=>false, "service_centre"=>{"is_a_service_centre"=>false, "intro_paragraph"=>"", "intro_paragraph_cy"=>""}}
      C100App::CourtfinderAPI.any_instance.stub(:court_for).and_return(stub_resp)
      C100App::CourtfinderAPI.any_instance.stub(:court_lookup).and_return(court_lookup_resp)
      begin
        find_button("#{text}").click
      rescue
        click_link(text)
      end
    end
  end
end

When(/^I click the postcode page "([^"]*)" button with an invalid postcode$/) do |text|
  RSpec::Mocks.with_temporary_scope do
    C100App::CourtfinderAPI.any_instance.stub(:court_for).and_return({"courts"=>[]})

    find_button("#{text}").click
  end
end

When(/^I have started an application$/) do
  # replacing the override passcode link with normal way
  visit '/'
  expect(home_page.content).to have_header
  home_page.submit_postcode('MK93DX')

  expect(what_you_need_page.content).to have_header
  what_you_need_page.continue_to_next_step

  expect(consent_order_page.content).to have_header
end

When(/^I am on the home page$/) do
  step %[I visit "/"]
  find(:css, 'h1', text: 'What you’ll need to complete your application')
end

When(/^I pause for "([^"]*)" seconds$/) do |seconds|
  sleep seconds.to_i
end

And(/^Page has title "([^"]*)"/) do |text|
  expect(page).to have_title(text)
end

Given("I stub fact api call") do
  WebMock.enable!
  WebMock.allow_net_connect!
  WebMock::API.stub_request(:get, "https://www.find-court-tribunal.service.gov.uk/v2/proxy/search/postcode/TQ121XX/serviceArea/childcare-arrangements").
    to_return(status: 200, body: "{}", headers: {})

  WebMock::API.stub_request(:get, "https://www.find-court-tribunal.service.gov.uk/health").
    to_return(status: 200, body: "{\"mapit-api\":{\"status\":\"UP\"}}", headers: {})
end

And(/^I wait for (\d+) minutes$/) do |arg|
  travel arg.minutes
end

Given(/^I have completed an application$/) do
  step %[I visit "/"]
  step %[I open the "Developer Tools" summary details]
  find('button', text: 'Bypass to CYA', exact_text: true).click
end

When(/^I start the application$/) do
  find("a[href='/steps/opening/postcode']").click
end

When(/^I fill in a postcode for the children$/) do
  fill_in('steps_opening_postcode_form[children_postcode]', with: 'MK9 3DX')
end

When(/^I fill in a postcode "([^"]*)" for the children$/) do |arg|
  fill_in('steps_opening_postcode_form[children_postcode]', with: arg)
end

Given(/^Opening changes apply$/) do
  @original_prl_date = Rails.application.config.prl_opening_date
  Rails.application.config.prl_opening_date = Date.today - 1.day
end

Given(/^Opening changes do not apply$/) do
  @original_prl_date = Rails.application.config.prl_opening_date
  Rails.application.config.prl_opening_date = Date.today + 1.day
end

And('the opening changes end') do
  Rails.application.config.prl_opening_date = @original_prl_date
end

Given(/^Privacy changes apply$/) do
  ENV['PRIVACY_CHANGE'] = 'true'
end

When('court finder raises an error') do
  courtfinder_mock = instance_double(C100App::CourtfinderAPI, is_ok?: false)
  allow(C100App::CourtfinderAPI).to receive(:new).and_return(courtfinder_mock)
  allow(courtfinder_mock).to receive(:court_for).and_raise(StandardError.new('Courtfinder API error'))
end

Given('stub court finder responses') do
  courtfinder_mock = instance_double(C100App::CourtfinderAPI, is_ok?: false)
  allow(C100App::CourtfinderAPI).to receive(:new).and_return(courtfinder_mock)
end

Given('debugger') do
  binding.pry
  :a
end

When('I navigate to the Safety concerns from consent order page') do
  consent_order_page.submit_without_consent_order
  child_protection_case_page.submit_yes
  expect(miam_page.content).to have_text('You do not have to attend a MIAM')

  miam_page.continue_to_next_step
  expect(safety_concern_page.content).to have_header
end

When('I let session to expire') do
  travel_to 61.minutes.from_now do
    # save_and_open_page
    expect(page).to have_text("Sorry, you'll have to start again")
  end
end

When('I navigate to applicant names page from consent order') do
  consent_order_page.submit_without_consent_order
  child_protection_case_page.submit_yes
  expect(miam_page.content).to have_text('You do not have to attend a MIAM')

  miam_page.continue_to_next_step
  expect(safety_concern_page.content).to have_header

  safety_concern_page.continue_to_next_step
  # Navigate through safety questions to get to applicant names
  # This is a simplified path - in reality may need more steps
end

When('I complete the applicant details journey') do
  # Add a child first
  children_names_page.add_child('John', 'Doe Junior')

  # Navigate to applicant names
  applicant_names_page.submit_names('John', 'Doe Senior')

  # Privacy questions
  applicant_privacy_known_page.submit_yes
  applicant_privacy_preferences_page.submit_no
  applicant_refuge_page.submit_no

  # Personal details
  applicant_personal_details_page.submit_personal_details(
    has_previous_name: 'no',
    gender: 'male',
    day: '25',
    month: '05',
    year: '1998',
    birthplace: 'Manchester'
  )

  # Relationship
  applicant_relationship_page.submit_relationship('Father')

  # Address
  address_lookup_page.click_outside_uk
  applicant_address_details_page.submit_address_details(
    address_line_1: 'Test street',
    town: 'London',
    country: 'United Kingdom',
    residence_5_years: 'yes'
  )

  # Contact details
  applicant_contact_details_page.submit_contact_details(
    email: 'john@email.com',
    phone: '00000000000',
    voicemail_consent: 'yes'
  )

  # Solicitor
  applicant_has_solicitor_page.submit_no
end
