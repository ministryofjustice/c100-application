And(/^I should be on the Check Your Answers page$/) do
  expect(cya_page).to be_displayed
  expect(cya_page.content).to have_header
end

And(/^I should see that all alternatives "(have|haven't)" been tried$/) do |arg|
  answer = (arg == "have" ? "Yes" : "No")
  expect(cya_page.alternatives.alternative_negotiation_tools.answer).to eq(answer)
  expect(cya_page.alternatives.alternative_mediation.answer).to eq("No")
  expect(cya_page.alternatives.alternative_lawyer_negotiation.answer).to eq(answer)
  expect(cya_page.alternatives.alternative_collaborative_law.answer).to eq(answer)
end

And(/^I should see the children details:$/) do |table|
  answer_children = table.hashes

  expect(cya_page.children_details.children.count).to eq(answer_children.size)

  answer_children.each_with_index do |child_data, i|
    expect(cya_page.children_details.full_name[i].answer).to eq(child_data['full_name'])
    expect(cya_page.children_details.personal_details[i].dob).to eq(child_data['dob'])
    expect(cya_page.children_details.personal_details[i].sex).to eq(child_data['sex'])
    expect(cya_page.children_details.child_orders[i].answer).to eq(child_data['child_orders'])
    expect(cya_page.children_details.special_guardianship_order[i].answer).to eq(child_data['special_guardianship'])
    expect(cya_page.children_details.parental_responsibility[i].answer).to eq(child_data['parental_responsibility'])
  end
end

And(/^I should see the applicant personal details$/) do |table|
  answer_applicants = table.hashes

  expect(cya_page.applicants_details.applicants.count).to eq(answer_applicants.size)

  answer_applicants.each_with_index do |applicant_data, i|
    expect(cya_page.applicants_details.refuge[i].answer).to eq(applicant_data['refuge'])
    expect(cya_page.applicants_details.privacy_known[i].answer).to eq(applicant_data['privacy_known'])
    expect(cya_page.applicants_details.contact_details_private[i].answer).to eq(applicant_data['contact_details_private'])
    expect(cya_page.applicants_details.full_name[i].answer).to eq(applicant_data['full_name'])
    expect(cya_page.applicants_details.personal_details[i].dob).to eq(applicant_data['dob'])
    expect(cya_page.applicants_details.personal_details[i].sex).to eq(applicant_data['sex'])
    expect(cya_page.applicants_details.personal_details[i].birthplace).to eq(applicant_data['birthplace'])
    expect(cya_page.applicants_details.relationship_to_child[i].answer).to eq(applicant_data['relationship_to_child'])
  end
end

And(/^I should see the applicant address and contact details:$/) do |table|
  answer_applicants = table.hashes

  expect(cya_page.applicants_details.applicants.count).to eq(answer_applicants.size)

  answer_applicants.each_with_index do |applicant_data, i|
    expect(cya_page.applicants_details.address_details[i].address.answer).to eq(applicant_data['address'])
    expect(cya_page.applicants_details.address_details[i].lived_at_5_years.answer).to eq(applicant_data['lived_at_5_years'])
    expect(cya_page.applicants_details.contact_details[i].email_provided.answer).to eq(applicant_data['email_provided'])
    expect(cya_page.applicants_details.contact_details[i].email.answer).to eq(applicant_data['email'])
    expect(cya_page.applicants_details.contact_details[i].phone_number.answer).to eq(applicant_data['phone_number'])
    expect(cya_page.applicants_details.contact_details[i].voicemail_consent.answer).to eq(applicant_data['voicemail_consent'])
  end
end

And(/^I should see the solicitor details:$/) do |table|
  answer_solicitor = table.hashes[0]

  expect(cya_page.solicitor_details.has_solicitor).to be_yes
  expect(cya_page.solicitor_details.personal_details.full_name.answer).to eq(answer_solicitor['full_name'])
  expect(cya_page.solicitor_details.personal_details.firm_name.answer).to eq(answer_solicitor['firm_name'])
  expect(cya_page.solicitor_details.address_details.address.answer).to eq(answer_solicitor['address'])
  expect(cya_page.solicitor_details.contact_details.email.answer).to eq(answer_solicitor['email'])
  expect(cya_page.solicitor_details.contact_details.phone_number.answer).to eq(answer_solicitor['phone_number'])
  expect(cya_page.solicitor_details.contact_details.dx_number.answer).to eq(answer_solicitor['dx_number'])
end

And(/^I should see the respondents details:$/) do |table|
  answer_respondents = table.hashes

  expect(cya_page.respondents_details.respondents.count).to eq(answer_respondents.size)

  answer_respondents.each_with_index do |respondents_data, i|
    expect(cya_page.respondents_details.full_name[i].answer).to eq(respondents_data['full_name'])
    expect(cya_page.respondents_details.relationship_to_child[i].answer).to eq(respondents_data['relationship'])
    expect(cya_page.respondents_details.personal_details[i].dob).to eq(respondents_data['dob'])
    expect(cya_page.respondents_details.personal_details[i].sex).to eq(respondents_data['sex'])
    expect(cya_page.respondents_details.address_details[i].address.answer).to eq(respondents_data['address'])
    expect(cya_page.respondents_details.address_details[i].lived_at_5_years.answer).to eq(respondents_data['lived_at_5_years'])
    expect(cya_page.respondents_details.contact_details[i].email.answer).to eq(respondents_data['email'])
    expect(cya_page.respondents_details.contact_details[i].phone_number.answer).to eq(respondents_data['phone_number'])
  end
end

And(/^I should see the children residence details:$/) do |table|
  answer_residence = table.hashes

  answer_residence.each_with_index do |residence_data, i|
    expect(cya_page.children_residence.child[i].child_name).to eq(residence_data['child_name'])
    expect(cya_page.children_residence.child[i].residence).to eq(residence_data['residence'])
  end
end

And(/^I should see details for other proceedings involving the children:$/) do |table|
  answer_proceedings = table.hashes

  expect(cya_page.other_court_cases.has_other_court_cases).to be_yes

  answer_proceedings.each_with_index do |proceeding_data, i|
    expect(cya_page.other_court_cases.details.children_names.answer).to eq(proceeding_data['child_name'])
    expect(cya_page.other_court_cases.details.court_name.answer).to eq(proceeding_data['court_name'])
    expect(cya_page.other_court_cases.details.proceedings_date.answer).to eq(proceeding_data['date'])
    expect(cya_page.other_court_cases.details.order_types.answer).to eq(proceeding_data['order_type'])
    expect(cya_page.other_court_cases.details.previous_details.answer).to eq(proceeding_data['previous_details'])
  end
end