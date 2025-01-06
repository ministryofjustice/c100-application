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

When(/^I click the "([^"]*)" link$/) do |text|
  find(:xpath, './/main', visible: true, wait: true)
  click_link(text, wait: true)
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
  sleep 1
  find_button("#{text}").click
end

When(/^I wait and click the "([^"]*)" button$/) do |text|
  travel 61.minutes do
    begin
      find_button("#{text}").click
    rescue
      click_link(text)
    end
  end
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
    court_lookup_resp = {"name"=>"Coventry Combined Court Centre", "slug"=>"coventry-combined-court-centre", "info"=>"<p><a href=https://www.gov.uk/government/news/scammers-using-hmcts-telephone-numbers>Scammers are mimicking genuine HMCTS phone numbers and email addresses</a>. They may demand payment and claim to be from HMRC or enforcement. If you're unsure, do not pay anything and report the scam to <a href=https://www.actionfraud.police.uk/>Action Fraud</a>.</p>", "open"=>true, "directions"=>nil, "image_file"=>"coventry_combined_court_centre.jpg", "lat"=>52.4055836530515, "lon"=>-1.50643963844351, "urgent_message"=>"", "crown_location_code"=>417, "family_location_code"=>180, "magistrates_location_code"=>nil, "family_location_code"=>180, "tribunal_location_code"=>nil, "areas_of_law"=>[{"name"=>"Adoption", "external_link"=>"https://www.gov.uk/child-adoption", "display_url"=>nil, "external_link_desc"=>"Information about adopting a child", "display_name"=>nil, "display_external_link"=>"https://www.gov.uk/child-adoption/applying-for-an-adoption-court-order"}, {"name"=>"Bankruptcy", "external_link"=>"https://www.gov.uk/apply-for-bankruptcy", "display_url"=>nil, "external_link_desc"=>"Information about applying for bankruptcy", "display_name"=>nil, "display_external_link"=>"https://www.gov.uk/bankruptcy"}, {"name"=>"Children", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>"Childcare arrangements if you separate from your partner", "display_external_link"=>"https://www.gov.uk/looking-after-children-divorce"}, {"name"=>"Crime", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>nil, "display_external_link"=>nil}, {"name"=>"Divorce", "external_link"=>"https://www.gov.uk/divorce", "display_url"=>nil, "external_link_desc"=>"Information about getting a divorce", "display_name"=>"Divorce hearings", "display_external_link"=>nil}, {"name"=>"Domestic violence", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>"Domestic abuse", "display_external_link"=>"https://www.gov.uk/injunction-domestic-violence"}, {"name"=>"High Court District Registry", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>"High Court cases – serious or high profile criminal or civil law cases", "display_external_link"=>nil}, {"name"=>"Housing possession", "external_link"=>"https://www.gov.uk/evicting-tenants", "display_url"=>nil, "external_link_desc"=>"Information about evicting tenants", "display_name"=>"Housing", "display_external_link"=>nil}, {"name"=>"Money claims", "external_link"=>"https://www.gov.uk/make-court-claim-for-money", "display_url"=>nil, "external_link_desc"=>"Information about making a court claim for money", "display_name"=>nil, "display_external_link"=>nil}, {"name"=>"Single justice procedure", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>nil, "display_external_link"=>nil}], "types"=>["Family Court", "County Court", "Crown Court"], "emails"=>[{"address"=>"warwickcrowncourt@justice.gov.uk", "description"=>"Crown court", "explanation"=>nil}, {"address"=>"bailiffs.coventry.countycourt@justice.gov.uk", "description"=>"Enforcement", "explanation"=>nil}, {"address"=>"civilenquiries.coventry.countycourt@justice.gov.uk", "description"=>"County court", "explanation"=>"Civil enquiries"}, {"address"=>"Civilhearings.coventry.countycourt@justice.gov.uk", "description"=>"Listing", "explanation"=>nil}, {"address"=>"coventry.breathingspace@justice.gov.uk", "description"=>"Breathing space enquiries", "explanation"=>""}, {"address"=>"divorce.coventry.countycourt@justice.gov.uk", "description"=>"Family court", "explanation"=>nil}, {"address"=>"children.coventry.countycourt@justice.gov.uk", "description"=>"Family public law (children in care)", "explanation"=>"Paper process"}, {"address"=>"contactfpl@justice.gov.uk", "description"=>"Family public law (children in care)", "explanation"=>"Digital process for case numbers starting with C5"}, {"address"=>"coventryprivatelawapplications@justice.gov.uk", "description"=>"Applications", "explanation"=>"C100 applications"}], "contacts"=>[{"number"=>"0300 332 1000", "description"=>"Enquiries", "explanation"=>"Witness Services enquiries"}, {"number"=>"0300 123 5577", "description"=>"County court", "explanation"=>""}, {"number"=>"0247 653 6322", "description"=>"Counter appointments", "explanation"=>""}, {"number"=>"01926 429 133", "description"=>"Crown court", "explanation"=>""}, {"number"=>"0330 808 4424", "description"=>"Family public law (children in care)", "explanation"=>"Digital process for case numbers starting with C5"}, {"number"=>"01264 347 973", "description"=>"Fax", "explanation"=>""}], "opening_times"=>[{"description"=>"Counter service by appointment only", "hours"=>"Monday to Friday 10am to 2pm", "description_cy"=>nil}, {"description"=>"Telephone enquiries answered", "hours"=>"Monday to Friday 8:30am to 5pm", "description_cy"=>nil}, {"description"=>"Court open", "hours"=>"Monday to Friday 9am to 5pm", "description_cy"=>nil}], "application_updates"=>[], "facilities"=>[{"description"=>"This building has level access to the building entrance, and court room.\r\n ", "name"=>"Disabled access", "order"=>2}, {"description"=>"Assistance dogs are welcome.", "name"=>"Assistance dogs", "order"=>4}, {"description"=>"The building has hearing enhancement facilities available by prior arrangement.  Please contact the Court office by telephone or email if necessary.", "name"=>"Hearing Loop", "order"=>5}, {"description"=>"Refreshments are available via Vending Machine.", "name"=>"Refreshments", "order"=>11}, {"description"=>"4 interview rooms are available on the ground floor", "name"=>"Interview room", "order"=>12}, {"description"=>"This Court has a childrens room facility.", "name"=>"Children's waiting room", "order"=>14}, {"description"=>"Baby changing facilities are available in the disabled toilets on the ground floor\r\n ", "name"=>"Baby changing facility", "order"=>15}, {"description"=>"Court/hearing room video conferencing facilities and prison to court video link facilities are available by prior arrangement.Please contact the Court administration to check availability.\r\n \r\n.\r\n ", "name"=>"Video facilities", "order"=>17}, {"description"=>" \r\nSupport for witnesses is available from the <a href=\"https://www.citizensadvice.org.uk/\" rel=\"nofollow\">Citizens Advice</a> witness service. Support Through Court is available on Mondays to provide assistance.", "name"=>"Witness service", "order"=>19}], "addresses"=>[{"address_lines"=>["140 Much Park Street"], "postcode"=>"CV1 2SN", "town"=>"Coventry", "type"=>"Visit or contact us", "county"=>"Warwickshire", "description"=>nil, "fields_of_law"=>nil}], "gbs"=>"Y260", "dx_number"=>["701580 Coventry 5"], "service_area"=>[], "in_person"=>true, "access_scheme"=>true, "additional_links"=>[{"url"=>"https://www.gov.uk/guidance/debt-respite-breathing-space-scheme-creditors-responsibilities-to-the-court", "description"=>"Breathing Space"}], "common_flag"=>false, "service_centre"=>{"is_a_service_centre"=>false, "intro_paragraph"=>"", "intro_paragraph_cy"=>""}}
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
      court_lookup_resp = {"name"=>"Coventry Combined Court Centre", "slug"=>"coventry-combined-court-centre", "info"=>"<p><a href=https://www.gov.uk/government/news/scammers-using-hmcts-telephone-numbers>Scammers are mimicking genuine HMCTS phone numbers and email addresses</a>. They may demand payment and claim to be from HMRC or enforcement. If you're unsure, do not pay anything and report the scam to <a href=https://www.actionfraud.police.uk/>Action Fraud</a>.</p>", "open"=>true, "directions"=>nil, "image_file"=>"coventry_combined_court_centre.jpg", "lat"=>52.4055836530515, "lon"=>-1.50643963844351, "urgent_message"=>"", "crown_location_code"=>417, "family_location_code"=>180, "magistrates_location_code"=>nil, "family_location_code"=>nil, "tribunal_location_code"=>nil, "areas_of_law"=>[{"name"=>"Adoption", "external_link"=>"https://www.gov.uk/child-adoption", "display_url"=>nil, "external_link_desc"=>"Information about adopting a child", "display_name"=>nil, "display_external_link"=>"https://www.gov.uk/child-adoption/applying-for-an-adoption-court-order"}, {"name"=>"Bankruptcy", "external_link"=>"https://www.gov.uk/apply-for-bankruptcy", "display_url"=>nil, "external_link_desc"=>"Information about applying for bankruptcy", "display_name"=>nil, "display_external_link"=>"https://www.gov.uk/bankruptcy"}, {"name"=>"Children", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>"Childcare arrangements if you separate from your partner", "display_external_link"=>"https://www.gov.uk/looking-after-children-divorce"}, {"name"=>"Crime", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>nil, "display_external_link"=>nil}, {"name"=>"Divorce", "external_link"=>"https://www.gov.uk/divorce", "display_url"=>nil, "external_link_desc"=>"Information about getting a divorce", "display_name"=>"Divorce hearings", "display_external_link"=>nil}, {"name"=>"Domestic violence", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>"Domestic abuse", "display_external_link"=>"https://www.gov.uk/injunction-domestic-violence"}, {"name"=>"High Court District Registry", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>"High Court cases – serious or high profile criminal or civil law cases", "display_external_link"=>nil}, {"name"=>"Housing possession", "external_link"=>"https://www.gov.uk/evicting-tenants", "display_url"=>nil, "external_link_desc"=>"Information about evicting tenants", "display_name"=>"Housing", "display_external_link"=>nil}, {"name"=>"Money claims", "external_link"=>"https://www.gov.uk/make-court-claim-for-money", "display_url"=>nil, "external_link_desc"=>"Information about making a court claim for money", "display_name"=>nil, "display_external_link"=>nil}, {"name"=>"Single justice procedure", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>nil, "display_external_link"=>nil}], "types"=>["Family Court", "County Court", "Crown Court"], "emails"=>[{"address"=>"warwickcrowncourt@justice.gov.uk", "description"=>"Crown court", "explanation"=>nil}, {"address"=>"bailiffs.coventry.countycourt@justice.gov.uk", "description"=>"Enforcement", "explanation"=>nil}, {"address"=>"civilenquiries.coventry.countycourt@justice.gov.uk", "description"=>"County court", "explanation"=>"Civil enquiries"}, {"address"=>"Civilhearings.coventry.countycourt@justice.gov.uk", "description"=>"Listing", "explanation"=>nil}, {"address"=>"coventry.breathingspace@justice.gov.uk", "description"=>"Breathing space enquiries", "explanation"=>""}, {"address"=>"divorce.coventry.countycourt@justice.gov.uk", "description"=>"Family court", "explanation"=>nil}, {"address"=>"children.coventry.countycourt@justice.gov.uk", "description"=>"Family public law (children in care)", "explanation"=>"Paper process"}, {"address"=>"contactfpl@justice.gov.uk", "description"=>"Family public law (children in care)", "explanation"=>"Digital process for case numbers starting with C5"}, {"address"=>"coventryprivatelawapplications@justice.gov.uk", "description"=>"Applications", "explanation"=>"C100 applications"}], "contacts"=>[{"number"=>"0300 332 1000", "description"=>"Enquiries", "explanation"=>"Witness Services enquiries"}, {"number"=>"0300 123 5577", "description"=>"County court", "explanation"=>""}, {"number"=>"0247 653 6322", "description"=>"Counter appointments", "explanation"=>""}, {"number"=>"01926 429 133", "description"=>"Crown court", "explanation"=>""}, {"number"=>"0330 808 4424", "description"=>"Family public law (children in care)", "explanation"=>"Digital process for case numbers starting with C5"}, {"number"=>"01264 347 973", "description"=>"Fax", "explanation"=>""}], "opening_times"=>[{"description"=>"Counter service by appointment only", "hours"=>"Monday to Friday 10am to 2pm", "description_cy"=>nil}, {"description"=>"Telephone enquiries answered", "hours"=>"Monday to Friday 8:30am to 5pm", "description_cy"=>nil}, {"description"=>"Court open", "hours"=>"Monday to Friday 9am to 5pm", "description_cy"=>nil}], "application_updates"=>[], "facilities"=>[{"description"=>"This building has level access to the building entrance, and court room.\r\n ", "name"=>"Disabled access", "order"=>2}, {"description"=>"Assistance dogs are welcome.", "name"=>"Assistance dogs", "order"=>4}, {"description"=>"The building has hearing enhancement facilities available by prior arrangement.  Please contact the Court office by telephone or email if necessary.", "name"=>"Hearing Loop", "order"=>5}, {"description"=>"Refreshments are available via Vending Machine.", "name"=>"Refreshments", "order"=>11}, {"description"=>"4 interview rooms are available on the ground floor", "name"=>"Interview room", "order"=>12}, {"description"=>"This Court has a childrens room facility.", "name"=>"Children's waiting room", "order"=>14}, {"description"=>"Baby changing facilities are available in the disabled toilets on the ground floor\r\n ", "name"=>"Baby changing facility", "order"=>15}, {"description"=>"Court/hearing room video conferencing facilities and prison to court video link facilities are available by prior arrangement.Please contact the Court administration to check availability.\r\n \r\n.\r\n ", "name"=>"Video facilities", "order"=>17}, {"description"=>" \r\nSupport for witnesses is available from the <a href=\"https://www.citizensadvice.org.uk/\" rel=\"nofollow\">Citizens Advice</a> witness service. Support Through Court is available on Mondays to provide assistance.", "name"=>"Witness service", "order"=>19}], "addresses"=>[{"address_lines"=>["140 Much Park Street"], "postcode"=>"CV1 2SN", "town"=>"Coventry", "type"=>"Visit or contact us", "county"=>"Warwickshire", "description"=>nil, "fields_of_law"=>nil}], "gbs"=>"Y260", "dx_number"=>["701580 Coventry 5"], "service_area"=>[], "in_person"=>true, "access_scheme"=>true, "additional_links"=>[{"url"=>"https://www.gov.uk/guidance/debt-respite-breathing-space-scheme-creditors-responsibilities-to-the-court", "description"=>"Breathing Space"}], "common_flag"=>false, "service_centre"=>{"is_a_service_centre"=>false, "intro_paragraph"=>"", "intro_paragraph_cy"=>""}}
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

When(/^I have started an application$/) do
  step %[I visit "/"]
  step %[I open the "Developer Tools" summary details]
  find('button', text: 'Bypass postcode').click
  step %[I should be on "/steps/opening/consent_order"]
end

When(/^I am on the home page$/) do
  step %[I visit "/"]
end

When(/^I pause for "([^"]*)" seconds$/) do |seconds|
  sleep seconds.to_i
end

And(/^Page has title "([^"]*)"/) do |text|
  expect(page).to have_title(text)
end

And(/^analytics cookies are NOT allowed to be set$/) do
  expect(page.evaluate_script("window['ga-disable-#{Rails.application.config.x.analytics_tracking_id}']"))
    .to be(true), 'Google analytics is enabled it should not be'
end

Then(/^google analytics cookies are allowed to be set$/) do
  expect(any_page).to have_google_analytics_enabled
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
  ENV['PRL_OPENING'] = 'true'
end

Given(/^Opening changes do not apply$/) do
  ENV['PRL_OPENING'] = 'false'
end

Given(/^Confidential changes do apply$/) do
  @original_confidential_date = Rails.application.config.confidential_option_date
  Rails.application.config.confidential_option_date= Date.today - 1.day
end

Given(/^Confidential changes do not apply$/) do
  @original_confidential_date = Rails.application.config.confidential_option_date
  Rails.application.config.confidential_option_date= Date.today + 1.day
end

And('the confidential changes end') do
  Rails.application.config.confidential_option_date = @original_confidential_date
end

Given(/^Privacy changes apply$/) do
  ENV['PRIVACY_CHANGE'] = 'true'
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  find(:xpath, './/main//form', visible: true, wait: true)
  fill_in(field, with: value)
rescue Selenium::WebDriver::Error::UnknownError => e
  find(:xpath, './/main//form', visible: true, wait: true)
  fill_in(field, with: value)
end

And(/^I check "([^"]*)"$/) do |text|
  find(:xpath, './/main//form', visible: true, wait: true)
  check(text, allow_label_click: true)
rescue Selenium::WebDriver::Error::UnknownError => e
  find(:xpath, './/main//form', visible: true, wait: true)
  find('label', text: text).click
end

When(/^I click the radio button "([^"]*)"$/) do |text|
  find(:xpath, './/main//form', visible: true, wait: true)
  find('label', text: text).click
end

Then(/^I click "([^"]*)" for the radio button "([^"]*)"$/) do |text, legend|
  find(
    'legend > span', text: legend
  ).ancestor(
    'fieldset', order: :reverse, match: :first
  ).find(
    'label', text: text
  ).click
end

When(/^I choose "([^"]*)"$/) do |text|
  find(:xpath, './/main//form', visible: true, wait: true)
  step %[I click the radio button "#{text}"]
  find_button('Continue').click
end

And(/^I choose "([^"]*)" and fill in "([^"]*)" with "([^"]*)"$/) do |text, field, value|
  step %[I click the radio button "#{text}"]
  step %[I fill in "#{field}" with "#{value}"]
  find_button('Continue').click
end

When(/^I enter the date (\d+)\-(\d+)\-(\d+)$/) do |day, month, year|
  step %[I fill in "Day" with "#{day}"]
  step %[I fill in "Month" with "#{month}"]
  step %[I fill in "Year" with "#{year}"]
end

# For children sub form on safety concerns
Then(/^I submit the form details for "([^"]*)"$/) do |heading|
  step %[I should see "#{heading}"]
  step %[I fill in "Briefly describe what happened and who was involved, if you feel able to" with "Information..."]

  step %[I fill in "When did this behaviour start?" with "2 weeks ago"]

  step %[I click "No" for the radio button "Is the behaviour still ongoing?"]
  step %[I fill in "When did the behaviour stop?" with "1 weeks ago"]

  step %[I click "Yes" for the radio button "Have you ever asked for help?"]
  step %[I fill in "Who did you ask for help?" with "Friend"]

  step %[I click "Yes" for the radio button "Did they help you?"]
  step %[I fill in "What did they do?" with "Information..."]

  step %[I click the "Continue" button]
end

# Needed for the children journey
When(/^I have selected orders for the court to decide$/) do
  step %[I visit "steps/petition/orders"]
  step %[I check "Decide who they live with and when"]
  step %[I check "Decide how much time they spend with each person"]
  step %[I click the "Continue" button]
  step %[I should see "Decide how much time they spend with each person"]
  step %[I should see "This is known as a Child Arrangements Order"]
end

# Needed for the applicant and respondent journeys
When(/^I have entered a child with first name "([^"]*)" and last name "([^"]*)"$/) do |first_name, last_name|
  step %[I visit "steps/children/names"]
  step %[I fill in "First name(s)" with "#{first_name}"]
  step %[I fill in "Last name(s)" with "#{last_name}"]
  step %[I click the "Continue" button]
  step %[I should see "Provide details for #{first_name} #{last_name}"]
end

Then(/^the analytics cookies radio buttons are defaulted to '([^']*)'$/) do |value|
  cookie_management_page.analytics_question.assert_value(value)
end

When(/^I select '([^']*)' for analytics cookies$/) do |value|
  cookie_management_page.analytics_question.set(value)
end

And(/^a confirmation box will appear telling me that my cookie settings have been saved$/) do
  expect(any_page).to have_cookie_preferences_updated_message
end

And(/^I choose "([^"]*)" for all options on this page$/) do |arg|
  options = page.all('label', text: arg)
  options.each do |radio_button|
    radio_button.click
  end
  find_button('Continue').click
end

And(/^I choose "([^"]*)" for all options on this page without continuing$/) do |arg|
  options = page.all('label', text: arg)
  options.each do |radio_button|
    radio_button.click
  end
end

And(/^I fill in the Expiry date with a valid card expiry date$/) do
  future = travel 365.day
  step %[I fill in "Month" with "#{future.month}"]
  step %[I fill in "Year" with "#{future.year}"]
end

When(/^I specify they are "(\d+)" years of age$/) do |age|
  today = Date.today
  date_of_birth = today - age.to_i.years

  step %[I fill in "Day" with "#{date_of_birth.day}"]
  step %[I fill in "Month" with "#{date_of_birth.month}"]
  step %[I fill in "Year" with "#{date_of_birth.year}"]
end

When(/^I should see "([^"]*)" in the error summary$/) do |text|
  expect(page.find("div.govuk-error-summary h2")).to have_text(text)
end

When(/^I should see "([^"]*)" error in the form$/) do |text|
  expect(page.find(".govuk-error-message")).to have_text(text)
end

Then(/^The form markup should match "([^"]*)"$/) do |fixture|
  raw_markup = page.all(
    :css, 'form > div.govuk-form-group'
  ).map { |div| div['outerHTML'] }.join

  raw_fixture = Pathname.new(
    File.join('features', 'fixtures', 'files', "#{fixture}.html")
  ).read

  normaliser = MarkupNormaliser.new(raw_markup, raw_fixture)
  expect(
    normaliser.markup1
  ).to eq(
         normaliser.markup2
       )
end

Then(/^The form markup with errors should match "([^"]*)"$/) do |fixture|
  # Click continue without filling anything, to trigger validation errors
  step %[I click the "Continue" button]

  # Now check the markup with errors using the above step
  step %[The form markup should match "#{fixture}"]
end