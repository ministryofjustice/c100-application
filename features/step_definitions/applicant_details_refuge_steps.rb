Then('I should see the applicant names page') do
  expect(applicant_names_page.content).to have_header
end

Then('I should see the applicant privacy known page') do
  expect(applicant_privacy_known_page).to be_displayed
end

And('I submitted a name for children names') do
  visit 'steps/children/names'
  children_names_page.content.first_name.set 'John'
  children_names_page.content.last_name.set 'Doe Junior'
  children_names_page.content.continue_button.click
  expect(children_personal_details_page).to be_displayed
end


Then('Page shows empty applicant names error') do
  expect(applicant_names_page).to have_title(applicant_names_page.error_title)
  expect(applicant_names_page.content).to have_error_link_1
  expect(applicant_names_page.content).to have_error_link_2
end

When(/I fill in applicant name with first name "([^"]*)" and last name "([^"]*)"/) do |first_name, last_name|
  applicant_names_page.content.first_name_error.set first_name
  applicant_names_page.content.last_name_error.set last_name
end

Then('Page shows special character applicant names error') do
  expect(applicant_names_page).to have_title(applicant_names_page.error_title)
  expect(applicant_names_page.content).to have_error_link_3
end

Then('Page shows applicant privacy known errors') do
  expect(applicant_privacy_known_page).to have_title(applicant_privacy_known_page.error_title)
  expect(applicant_privacy_known_page.content).to have_error_link
end

And(/I select "([^"]*)" for applicant privacy known options/) do |option|
  case option
  when 'Yes'
    applicant_privacy_known_page.content.yes.click
  when 'No'
    applicant_privacy_known_page.content.no.click
  when 'I don\'t know'
    applicant_privacy_known_page.content.not_known.click
  end
  applicant_privacy_known_page.content.continue_button.click
end

Then('I should see the applicant privacy preferences page') do
  expect(applicant_privacy_preferences_page).to be_displayed
end

Then('Page shows applicant privacy preferences errors') do
  expect(applicant_privacy_preferences_page).to have_title(applicant_privacy_preferences_page.error_title)
  expect(applicant_privacy_preferences_page.content).to have_error_link
end

And(/I select "([^"]*)" for applicant privacy preferences/) do |option|
  case option
  when 'Yes'
    applicant_privacy_preferences_page.content.yes.click
  when 'No'
    applicant_privacy_preferences_page.content.no.click
  end
  applicant_privacy_preferences_page.content.continue_button.click
end

Then('I should see the applicant refuge page') do
  expect(applicant_refuge_page).to be_displayed
end

And(/I select "([^"]*)" for applicant refuge options/) do |option|
  case option
  when 'Yes'
    applicant_refuge_page.content.yes.click
  when 'No'
    applicant_refuge_page.content.no.click
  end
  applicant_refuge_page.content.continue_button.click
end

Then('Page shows applicant refuge errors') do
  expect(applicant_refuge_page).to have_title(applicant_refuge_page.error_title)
  expect(applicant_refuge_page.content).to have_error_link
end

Then('I should see a not private privacy summary for applicant') do
  expect(applicant_privacy_summary_page.content).to have_header
  applicant_privacy_summary_page.content.continue_link.click
end

Then('I should see the applicant personal details page') do
  expect(applicant_personal_details_page).to be_displayed
end

Then('Page shows applicant personal details errors') do
  expect(applicant_personal_details_page).to have_title(applicant_personal_details_page.error_title)
  expect(applicant_personal_details_page.content).to have_error_link_1
  expect(applicant_personal_details_page.content).to have_error_link_2
  expect(applicant_personal_details_page.content).to have_error_link_3
  expect(applicant_personal_details_page.content).to have_error_link_4
end

Then(/I select "([^"]*)", "([^"]*)" for applicant personal details/) do |change, sex|
  case change
  when 'Yes'
    applicant_personal_details_page.content.yes.click
  when 'No'
    applicant_personal_details_page.content.no.click
  end

  case sex
  when 'Male'
    applicant_personal_details_page.content.male.click
  when 'Female'
    applicant_personal_details_page.content.female.click
  when 'Unspecified'
    applicant_personal_details_page.content.unspecified.click
  end
end

Then('Page shows applicant personal details date error') do
  expect(applicant_personal_details_page).to have_title(applicant_personal_details_page.error_title)
  expect(applicant_personal_details_page.content).to have_error_link_5
end

Then('Page shows applicant personal details date past error') do
  expect(applicant_personal_details_page).to have_title(applicant_personal_details_page.error_title)
  expect(applicant_personal_details_page.content).to have_error_link_6
end

Then('I should see the under age page') do
  expect(applicant_under_age_page).to be_displayed
end

Then('I should see the applicant relationship page') do
  expect(applicant_relationship_page).to be_displayed
end

Then('Page shows applicant relationship errors') do
  expect(applicant_relationship_page).to have_title(applicant_relationship_page.error_title)
  expect(applicant_relationship_page.content).to have_error_link
end

Then(/I choose applicant relationship to be "([^"]*)"/) do |relation|
  case relation
  when 'Father'
    applicant_relationship_page.content.father.click
  when 'Mother'
    applicant_relationship_page.content.mother.click
  when 'Guardian'
    applicant_relationship_page.content.guardian.click
  when 'Special Guardian'
    applicant_relationship_page.content.special_guardian.click
  when 'Grandparent'
    applicant_relationship_page.content.grandparent.click
  when 'Other'
    applicant_relationship_page.content.other.click
  end
  applicant_relationship_page.content.continue_button.click
end

Then('I should see the applicant address lookup page') do
  expect(address_lookup_page).to be_displayed
end

Then('Page shows address lookup errors') do
  expect(address_lookup_page).to have_title(address_lookup_page.error_title)
  expect(address_lookup_page.content).to have_error_link
end

Then('I should see the applicant address details page') do
  expect(applicant_address_details_page).to be_displayed
end

Then('Page shows applicant address details errors') do
  expect(applicant_address_details_page).to have_title(applicant_address_details_page.error_title)
  expect(applicant_address_details_page.content).to have_error_link_1
  expect(applicant_address_details_page.content).to have_error_link_2
  expect(applicant_address_details_page.content).to have_error_link_3
  expect(applicant_address_details_page.content).to have_error_link_4
end

Then('I should see the applicant contact details page') do
  expect(applicant_contact_details_page).to be_displayed
end

Then('Page shows applicant contact details errors') do
  expect(applicant_contact_details_page).to have_title(applicant_contact_details_page.error_title)
  expect(applicant_contact_details_page.content).to have_error_link_1
  expect(applicant_contact_details_page.content).to have_error_link_2
end

Then('Page shows applicant contact details errors for format') do
  expect(applicant_contact_details_page).to have_title(applicant_contact_details_page.error_title)
  expect(applicant_contact_details_page.content).to have_error_link_3
  expect(applicant_contact_details_page.content).to have_error_link_4
end

Then('I should see the has solicitor page') do
  expect(applicant_has_solicitor_page).to be_displayed
end

Then('I should see the respondent names page') do
  expect(respondent_names_page).to be_displayed
end

Then('I should see the solicitor personal details page') do
  expect(solicitor_personal_details_page).to be_displayed
end

Then('Page shows solicitor personal details errors') do
  expect(solicitor_personal_details_page).to have_title(solicitor_personal_details_page.error_title)
  expect(solicitor_personal_details_page.content).to have_error_link_1
  expect(solicitor_personal_details_page.content).to have_error_link_2
end

Then('Page shows solicitor personal details error for special characters') do
  expect(solicitor_personal_details_page).to have_title(solicitor_personal_details_page.error_title)
  expect(solicitor_personal_details_page.content).to have_error_link_3
end

Then('I should see the solicitor address details page') do
  expect(solicitor_address_details_page).to be_displayed
end

Then('Page shows solicitor address details errors') do
  expect(solicitor_address_details_page).to have_title(solicitor_address_details_page.error_title)
  expect(solicitor_address_details_page.content).to have_error_link_1
  expect(solicitor_address_details_page.content).to have_error_link_2
  expect(solicitor_address_details_page.content).to have_error_link_3
  expect(solicitor_address_details_page.content).to have_error_link_4
end

Then('Page shows solicitor address details error for postcode') do
  expect(solicitor_address_details_page).to have_title(solicitor_address_details_page.error_title)
  expect(solicitor_address_details_page.content).to have_error_link_5
end

Then('I should see the solicitor contact details page') do
  expect(solicitor_contact_details_page).to be_displayed
end

Then('Page shows solicitor contact details errors') do
  expect(solicitor_contact_details_page).to have_title(solicitor_contact_details_page.error_title)
  expect(solicitor_contact_details_page.content).to have_error_link_1
  expect(solicitor_contact_details_page.content).to have_error_link_2
end

Then('Page shows solicitor contact details errors for format') do
  expect(solicitor_contact_details_page).to have_title(solicitor_contact_details_page.error_title)
  expect(solicitor_contact_details_page.content).to have_error_link_3
  expect(solicitor_contact_details_page.content).to have_error_link_2
  expect(solicitor_contact_details_page.content).to have_error_link_4
end