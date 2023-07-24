And(/^I should see they haven't attended MIAM$/) do
  within('#miam_attended') do
    expect(page).to have_content("Have you attended a Mediation Information and Assessment Meeting (MIAM)? No")
  end
end

And(/^I should see they have attended MIAM$/) do
  within('#miam_attended') do
    expect(page).to have_content("Have you attended a Mediation Information and Assessment Meeting (MIAM)? Yes")
  end
end

And(/^I should see they have a document signed by the mediator$/) do
  within('#miam_certification') do
    expect(page).to have_content("Have you got a document signed by the mediator? Yes")
  end
end

And(/^I should see they are exempt from an MIAM$/) do
  within('#miam_mediator_exemption') do
    expect(page).to have_content("Has a mediator confirmed that you do not need to attend a MIAM? Yes")
  end
end

And(/^I should see they have safety concerns about the children$/) do
  within('#safety_concerns') do
    expect(page).to have_content("Yes")
  end
end

And(/^I should see they have no safety concerns about the children$/) do
  within('#safety_concerns') do
    expect(page).to have_content("No")
  end
end

And(/^I should see they have made an application related to a child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order$/) do
  within('#opening_questions') do
    expect(page).to have_content("Child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order")
  end
end

And(/^I should see they want the court to decide: "([^"]*)"$/) do |arg|
  within('#child_arrangements_orders') do
    expect(page).to have_content(arg)
  end
end

And(/^I should see the child's full name is "([^"]*)"$/) do |arg|
  within('#children_details') do
    expect(page).to have_content(arg)
  end
end

And(/^I should see the child's date of birth is "([^"]*)"$/) do |arg|
  within('#children_details') do
    expect(page).to have_content(arg)
  end
end

And(/^I should see the child's gender is "([^"]*)"$/) do |arg|
  within('#children_details') do
    expect(page).to have_content(arg)
  end
end

And(/^I should see the applicant's name is "([^"]*)"$/) do |arg|
  within('#applicants_details') do
    within('#person_full_name') do
      expect(page).to have_content(arg)
    end
  end
end

And(/^I should see the applicant's previous name is "([^"]*)"$/) do |arg|
  within('#applicants_details') do
    within('#person_previous_name') do
      expect(page).to have_content(arg)
    end
  end
end

And(/^I should see the applicant's gender is "([^"]*)"$/) do |arg|
  within('#applicants_details') do
    within('#person_sex') do
      expect(page).to have_content(arg)
    end
  end
end

And(/^I should see the applicant's date of birth is "([^"]*)"$/) do |arg|
  within('#applicants_details') do
    within('#person_dob') do
      expect(page).to have_content(arg)
    end
  end
end

And(/^I should see the applicant's place of birth is "([^"]*)"$/) do |arg|
  within('#applicants_details') do
    within('#person_birthplace') do
      expect(page).to have_content(arg)
    end
  end
end

And(/^I should see the applicant's address is "([^"]*)"$/) do |arg|
  within('#applicants_details') do
    within('#person_address_details') do
      within('#person_address') do
        expect(page).to have_content(arg)
      end
    end
  end
end

And(/^I should see the applicant has provided an email "([^"]*)"$/) do |arg|
  within('#applicants_details') do
    within('#person_contact_details') do
      within('#person_email') do
        expect(page).to have_content(arg)
      end
    end
  end
end

And(/^I should see the applicant has provided a home telephone number "([^"]*)"$/) do |arg|
  within('#applicants_details') do
    within('#person_contact_details') do
      within('#person_home_phone') do
        expect(page).to have_content(arg)
      end
    end
  end
end

And(/^I should see the applicant has provided a mobile number "([^"]*)"$/) do |arg|
  within('#applicants_details') do
    within('#person_contact_details') do
      within('#person_mobile_phone') do
        expect(page).to have_content(arg)
      end
    end
  end
end

And(/^I should see the applicant "(does|doesn't)" have a solicitor$/) do |arg|
  within('#solicitor_details') do
    within('#has_solicitor') do
      if arg == "does"
        expect(page).to have_content("Yes")
      elsif arg == "doesn't"
        expect(page).to have_content("No")
      end
    end
  end
end

And(/^I should see the solicitor's reference is "([^"]*)"$/) do |arg|
  within('#solicitor_details') do
    within('#solicitor_personal_details') do
      within('#solicitor_reference') do
        expect(page).to have_content(arg)
      end
    end
  end
end

And(/^I should see the solicitor's full name is "([^"]*)"$/) do |arg|
  within('#solicitor_details') do
    within('#solicitor_personal_details') do
      within('#solicitor_full_name') do
        expect(page).to have_content(arg)
      end
    end
  end
end

And(/^I should see the solicitor's address is "([^"]*)"$/) do |arg|
  within('#solicitor_details') do
    within('#solicitor_address_details') do
      within('#solicitor_address') do
        expect(page).to have_content(arg)
      end
    end
  end
end

And(/^I should see the solicitor's email is "([^"]*)" and phone number is "([^"]*)"$/) do |arg1, arg2|
  within('#solicitor_details') do
    within('#solicitor_contact_details') do
      within('#solicitor_email') do
        expect(page).to have_content(arg1)
      end
      within('#solicitor_phone_number') do
        expect(page).to have_content(arg2)
      end
    end
  end
end

And(/^I should see the respondent's name is "([^"]*)"$/) do |arg|
  within('#respondents_details') do
    within('#person_full_name') do
      expect(page).to have_content(arg)
    end
  end
end

And(/^I should see the respondent's date of birth is "([^"]*)"$/) do |arg|
  within('#respondents_details') do
    within('#person_personal_details') do
      within('#person_dob') do
        expect(page).to have_content(arg)
      end
    end
  end
end

And(/^I should see the respondent's gender is "([^"]*)"$/) do |arg|
  within('#respondents_details') do
    within('#person_personal_details') do
      within('#person_sex') do
        expect(page).to have_content(arg)
      end
    end
  end
end

And(/^I should see the respondent's place of birth is "([^"]*)"$/) do |arg|
  within('#respondents_details') do
    within('#person_personal_details') do
      within('#person_birthplace') do
        expect(page).to have_content(arg)
      end
    end
  end
end

And(/^I should see the respondent's address is "([^"]*)"$/) do |arg|
  within('#respondents_details') do
    within('#person_address_details') do
        expect(page).to have_content(arg)
    end
  end
end

And(/^I should see the respondent "(has|hasn't|might not have)" lived at that address for more than 5 years$/) do |arg|
  within('#respondents_details') do
    within('#person_address_details') do
      within('#person_residence_requirement_met') do
        if arg == "has"
          expect(page).to have_content("Yes")
        elsif arg == "hasn't"
          expect(page).to have_content("No")
        elsif arg == "might not have"
          expect(page).to have_content("Don't know")
        end
      end
    end
  end
end

And(/^I should see the respondent's email is "([^"]*)"$/) do |arg|
  within('#respondents_details') do
    within('#person_contact_details') do
      within('#person_email') do
        expect(page).to have_content(arg)
      end
    end
  end
end

And(/^I should see the respondent's mobile phone number is "([^"]*)"$/) do |arg|
  within('#respondents_details') do
    within('#person_contact_details') do
      within('#person_mobile_phone') do
        expect(page).to have_content(arg)
      end
    end
  end
end

And(/^I should see the respondent's relationship to "([^"]*)" is "([^"]*)"$/) do |arg1, arg2|
  children_rows = all('.govuk-summary-list__row')
  match = false
  children_rows.each do |element|
    if element.text.include?("Relationship to #{arg1}") && element.text.include?(arg2)
      match = true
      break
    end
  end
  expect(match).to be(true)
end

And(/^I should see there "(are|aren't)" other people who need to be informed of the application$/) do |arg|
  within('#other_parties_details') do
    within('#has_other_parties') do
      if arg == "are"
        expect(page).to have_content("Is there anyone else who should know about your application? Yes")
      elsif arg == "aren't"
        expect(page).to have_content("Is there anyone else who should know about your application? No")
      end
    end
  end
end

And(/^I should see the other party's name is "([^"]*)"$/) do |arg|
  within('#other_parties_details') do
    within('#person_full_name') do
      expect(page).to have_content(arg)
    end
  end
end

And(/^I should see the other party's gender is "([^"]*)"$/) do |arg|
  within('#other_parties_details') do
    within('#person_personal_details') do
      within('#person_sex') do
        expect(page).to have_content(arg)
      end
    end
  end
end

And(/^I should see the other party's date of birth is "([^"]*)"$/) do |arg|
  within('#other_parties_details') do
    within('#person_personal_details') do
      within('#person_dob') do
        expect(page).to have_content(arg)
      end
    end
  end
end

And(/^I should see the other party's address is "([^"]*)"$/) do |arg|
  within('#other_parties_details') do
    within('#person_address_details') do
      within('#person_address') do
        expect(page).to have_content(arg)
      end
    end
  end
end

And(/^I should see the other party's relationship to "([^"]*)" is "([^"]*)"$/) do |arg1, arg2|
  children_rows = all('.govuk-summary-list__row')
  match = false
  children_rows.each do |element|
    if element.text.include?("Relationship to #{arg1}") && element.text.include?(arg2)
      match = true
      break
    end
  end
  expect(match).to be(true)
end

And(/^I should see the child "([^"]*)" lives with "([^"]*)"$/) do |arg1, arg2|
  within('#children_residence') do
    within('#child_residence') do
      expect(page).to have_content(arg1)
      expect(page).to have_content(arg2)
    end
  end
end

And(/^I should see the children "(have|haven't)" been involved in other proceedings$/) do |arg|
  within('#other_court_cases') do
    within('#has_other_court_cases') do
      if arg == "have"
        expect(page).to have_content("Have any of the children in this application been involved in other family court proceedings? Yes")
      elsif arg == "haven't"
        expect(page).to have_content("Have any of the children in this application been involved in other family court proceedings? No")
      end
    end
  end
end

And(/^I should see the names of the children involved in other proceedings are "([^"]*)"$/) do |arg|
  within('#other_court_cases') do
    within('#court_proceeding_children_names') do
      expect(page).to have_content(arg)
    end
  end
end

And(/^I should see the name of the court is "([^"]*)"$/) do |arg|
  within('#other_court_cases') do
    within('#court_proceeding_court_name') do
      expect(page).to have_content(arg)
    end
  end
end

And(/^I should see the date of the proceeding is "([^"]*)"$/) do |arg|
  within('#other_court_cases') do
    within('#court_proceeding_proceedings_date') do
      expect(page).to have_content(arg)
    end
  end
end

And(/^I should see the type of proceeding is "([^"]*)"$/) do |arg|
  within('#other_court_cases') do
    within('#court_proceeding_order_types') do
      expect(page).to have_content(arg)
    end
  end
end

And(/^I should see an urgent hearing "(is|isn't)" requested$/) do |arg|
  element = find('dt.govuk-summary-list__key', text: 'Do you need an urgent hearing?')
  value_element = element.sibling('dd.govuk-summary-list__value')

  if arg == "is"
    expect(value_element).to have_content("Yes")
  elsif arg == "isn't"
    expect(value_element).to have_content("No")
  end
end

And(/^I should see a without notice hearing "(is|isn't)" requested$/) do |arg|
  element = find('dt.govuk-summary-list__key', text: 'Are you asking for a without notice hearing?')
  value_element = element.sibling('dd.govuk-summary-list__value')

  if arg == "is"
    expect(value_element).to have_content("Yes")
  elsif arg == "isn't"
    expect(value_element).to have_content("No")
  end
end

And(/^I should see the life of someone significant to the child "(is|isn't)" outside the UK$/) do |arg|
  international_rows = all('.app-cya--answers-group#international_resident')
  match = false
  international_rows.each do |element|
    if arg == "is"
      if element.text.include?("Yes")
        match = true
      end
    elsif arg == "isn't"
      if element.text.include?("No")
        match = true
      end
      break
    end
  end
  expect(match).to be(true)
end

And(/^I should see another person in this application "(could|couldn't)" apply for an order outside the UK$/) do |arg|
  international_rows = all('.app-cya--answers-group#international_jurisdiction')
  match = false
  international_rows.each do |element|
    if arg == "could"
      if element.text.include?("Yes")
        match = true
        break
      end
    elsif arg == "couldn't"
      if element.text.include?("No")
        match = true
        break
      end
    end
  end
  expect(match).to be(true)
end

And(/^I should see a request for information involving the children "(has|hasn't)" been made outside the UK$/) do |arg|
  international_rows = all('.app-cya--answers-group#international_request')
  match = false
  international_rows.each do |element|
    if arg == "has"
      if element.text.include?("Yes")
        match = true
        break
      end
    elsif arg == "hasn't"
      if element.text.include?("No")
        match = true
        break
      end
    end
  end
  expect(match).to be(true)
end

And(/^I should see the reason for application is "([^"]*)"$/) do |arg|
  within('#application_reasons') do
    within('#application_details') do
      expect(page).to have_content(arg)
    end
  end
end