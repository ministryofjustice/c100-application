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
