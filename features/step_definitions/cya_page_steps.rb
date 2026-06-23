And(/^I should see the children "(are|aren't)" involved in any emergency protection, care of proceedings$/) do |arg|
  answer = (arg == 'are' ? 'Yes' : 'No')
  expect(cya_page.opening_questions.child_protection_cases.answer).to eq(answer)
end

And(/^I should see they "(have|haven't)" been to mediation through the mediation voucher scheme$/) do |arg|
  answer = (arg == 'have' ? 'Yes' : 'No')
  expect(cya_page.mediation_voucher.voucher_scheme.answer).to eq(answer)
end

And(/^I should see they "(have|haven't)" attended a MIAM$/) do |arg|
  answer = (arg == 'have' ? 'Yes' : 'No')
  expect(cya_page.miam_requirement.miam_attended.answer).to eq(answer)
end

And(/^I should see they have a document signed by the mediator$/) do
  expect(cya_page.miam_requirement.miam_certificate.answer).to eq("Attached document\nimage.jpg")
end

And(/^I should see they "(have|haven't)" got safety concerns about the children$/) do |arg|
  answer = (arg == 'have' ? 'Yes' : 'No')
  expect(cya_page.safety_concerns.risk_of_abduction.answer).to eq(answer)
  expect(cya_page.safety_concerns.substance_abuse.details.answer).to eq(answer)
  expect(cya_page.safety_concerns.children_abuse.answer).to eq(answer)
  expect(cya_page.safety_concerns.domestic_abuse.answer).to eq(answer)
  expect(cya_page.safety_concerns.other_abuse.answer).to eq(answer)
end

And(/^I should see they "(have|haven't)" got safety concerns about domestic or child abuse$/) do |arg|
  answer = (arg == 'have' ? 'Yes' : 'No')
  expect(cya_page.safety_concerns.children_abuse.answer).to eq(answer)
end

def check_safety_concerns(expected_yes_concerns, safety_concerns)
  # Check that the provided answers equal 'Yes'
  expected_yes_concerns.each do |expected_concern|
    matching_concern = safety_concerns.keys.find { |question| question.include?(expected_concern) }
    expect(safety_concerns[matching_concern]).to eq('Yes'), "Concern does not equal 'Yes': #{expected_concern}"
  end

  # Check that all remaining concerns equal 'No'
  safety_concerns.each do |question, answer|
    next if expected_yes_concerns.include?(question)
    expect(answer).to eq('No'), "Concern does not equal 'No': #{question}"
  end
end

And(/^I should see they have safety concerns with the children about: "([^"]*)"$/) do |list|
  expected_yes_concerns = list.downcase.split(',').map(&:strip)
  concern = cya_page.children_abuse_details

  safety_concerns = {
    "abduction" => cya_page.safety_concerns.risk_of_abduction.answer,
    "drug alcohol or substance abuse" => cya_page.safety_concerns.substance_abuse.details.answer,
    concern.abuse_sexual.question.downcase => concern.abuse_sexual.answer,
    concern.abuse_physical.question.downcase => concern.abuse_physical.answer,
    concern.abuse_financial.question.downcase => concern.abuse_financial.answer,
    concern.abuse_psychological.question.downcase => concern.abuse_psychological.answer,
    concern.abuse_emotional.question.downcase => concern.abuse_emotional.answer,
    concern.abuse_other.question.downcase => concern.abuse_other.answer
  }

  check_safety_concerns(expected_yes_concerns, safety_concerns)
end

And(/^I should see they have safety concerns with themselves about: "([^"]*)"$/) do |list|
  expected_yes_concerns = list.downcase.split(',').map(&:strip)
  concern = cya_page.applicant_abuse_details

  safety_concerns = {
    concern.abuse_sexual.question.downcase => concern.abuse_sexual.answer,
    concern.abuse_physical.question.downcase => concern.abuse_physical.answer,
    concern.abuse_financial.question.downcase => concern.abuse_financial.answer,
    concern.abuse_psychological.question.downcase => concern.abuse_psychological.answer,
    concern.abuse_emotional.question.downcase => concern.abuse_emotional.answer,
    concern.abuse_other.question.downcase => concern.abuse_other.answer
  }

  check_safety_concerns(expected_yes_concerns, safety_concerns)
end

And(/^I should see they have made an application related to a child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order$/) do
  child_arrangements_order = 'Child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order'
  expect(cya_page.opening_questions.consent_order_application.answer).to eq(child_arrangements_order)
end

And(/^I should see they have made a consent order application$/) do
  expect(cya_page.opening_questions.consent_order_application.answer).to eq("Consent order")
end

And(/^I should see they want the court to decide: "([^"]*)"$/) do |arg|
  expect(cya_page.nature_of_application.child_arrangements_orders.answer).to eq(arg)
end

And(/^I should see they want the court to resolve an issue about: "([^"]*)"$/) do |arg|
  expect(cya_page.nature_of_application.specific_issues_orders.answer).to eq(arg)
end

And(/^I should see the children "(are|aren't|might be)" known to other social services$/) do |arg|
  if arg == 'are'
    expect(cya_page.children_further_info.known_to_authorities.answer).to eq('Yes')
  elsif arg == "aren't"
    expect(cya_page.children_further_info.known_to_authorities.answer).to eq('No')
  elsif arg == 'might be'
    expect(cya_page.children_further_info.known_to_authorities.answer).to eq("Don't know")
  end
end

And(/^I should see the applicant "(does|doesn't)" have a solicitor$/) do |arg|
  answer = (arg == 'does' ? 'Yes' : 'No')
  expect(cya_page.solicitor_details.has_solicitor.answer).to eq(answer)
end

And(/^I should see the respondent's relationship to "([^"]*)" is "([^"]*)"$/) do |arg1, arg2|
  children_rows = cya_page.respondents_details.relationship_to_child
  match = false
  children_rows.each do |element|
    if element.question.include?("Relationship to #{arg1}") && element.answer.include?(arg2)
      match = true
      break
    end
  end
  expect(match).to be(true)
end

And(/^I should see there "(are|aren't)" other people who need to be informed of the application$/) do |arg|
  answer = (arg == 'are' ? 'Yes' : 'No')
  expect(cya_page.other_parties_details.has_other_parties.answer).to eq(answer)
end

And(/^I should see the other party's name is "([^"]*)"$/) do |arg|
  expect(cya_page.other_parties_details.full_name[0].answer).to eq(arg)
end

And(/^I should see the children "(do|don't)" live with the other party$/) do |arg|
  answer = (arg == 'do' ? 'Yes' : 'No')
  expect(cya_page.other_parties_details.children_live_with_other_party[0].answer).to eq(answer)
end

And(/^I should see the other party "(does|doesn't)" want their identity to be kept private$/) do |arg|
  answer = (arg == 'does' ? 'Yes' : 'No')
  expect(cya_page.other_parties_details.identity_details_private[0].answer).to eq(answer)
end

And(/^I should see the other party "(does|doesn't)" want their contact details to be kept private$/) do |arg|
  answer = (arg == 'does' ? 'Yes' : 'No')
  expect(cya_page.other_parties_details.contact_details_private[0].answer).to eq(answer)
end

And(/^I should see the other party "(does|doesn't)" live in a refuge$/) do |arg|
  answer = (arg == 'does' ? 'Yes' : 'No')
  expect(cya_page.other_parties_details.refuge[0].answer).to eq(answer)
end

And(/^I should see the other party's gender is "([^"]*)"$/) do |arg|
  expect(cya_page.other_parties_details.personal_details[0].sex).to eq(arg)
end

And(/^I should see the other party's address is "([^"]*)"$/) do |arg|
  expect(cya_page.other_parties_details.address_details[0].address.answer).to eq(arg)
end

And(/^I should see the other party's relationship to "([^"]*)" is "([^"]*)"$/) do |arg1, arg2|
  children_rows = cya_page.other_parties_details.relationship_to_child
  match = false
  children_rows.each do |element|
    if element.question.include?("Relationship to #{arg1}") && element.answer.include?(arg2)
      match = true
      break
    end
  end
  expect(match).to be(true)
end

And(/^I should see the children "(have|haven't)" been involved in other proceedings$/) do |arg|
  answer = (arg == 'have' ? 'Yes' : 'No')
  expect(cya_page.other_court_cases.has_other_court_cases.answer).to eq(answer)
end

And(/^I should see an urgent hearing "(is|isn't)" requested$/) do |arg|
  answer = (arg == 'is' ? 'Yes' : 'No')
  expect(cya_page.urgent_hearing.needs_urgent_hearing.answer).to eq(answer)
end

And(/^I should see an urgent hearing is requested because "([^"]*)"$/) do |arg|
  expect(cya_page.urgent_hearing.details.additional_details.answer).to eq(arg)
end

And(/^I should see an urgent hearing is needed: "([^"]*)"$/) do |arg|
  expect(cya_page.urgent_hearing.when.answer).to eq(arg)
end

And(/^I should see a hearing "(is|isn't)" needed within the next 48 hours$/) do |arg|
  answer = (arg == 'is' ? 'Yes' : 'No')
  expect(cya_page.urgent_hearing.short_notice.answer).to eq(answer)
end

And(/^I should see a without notice hearing "(is|isn't)" requested$/) do |arg|
  answer = (arg == 'is' ? 'Yes' : 'No')
  expect(cya_page.without_notice_hearing.asking_for_without_notice_hearing.answer).to eq(answer)
end

And(/^I should see a without notice hearing is requested because "([^"]*)"$/) do |arg|
  expect(cya_page.without_notice_hearing.details.answer).to eq(arg)
end

And(/^I should see the life of someone significant to the child "(is|isn't)" outside the UK$/) do |arg|
  answer = (arg == 'is' ? 'Yes' : 'No')
  expect(cya_page.international_info.international_resident.details.answer).to eq(answer)
end

And(/^I should see another person in this application "(could|couldn't)" apply for an order outside the UK$/) do |arg|
  answer = (arg == 'could' ? 'Yes' : 'No')
  expect(cya_page.international_info.international_jurisdiction.can_apply_outside_en_cy.answer).to eq(answer)
end

And(/^I should see a request for information involving the children "(has|hasn't)" been made outside the UK$/) do |arg|
  answer = (arg == 'has' ? 'Yes' : 'No')
  expect(cya_page.international_info.international_request.answer).to eq(answer)
end

And(/^I should see the reason for application is "([^"]*)"$/) do |arg|
  expect(cya_page.application_reasons.details.answer).to eq(arg)
end

And(/^I should see there "(is|isn't)" a court order requiring permission to make this application$/) do |arg|
  answer = (arg == 'is' ? 'Yes' : 'No')
  expect(cya_page.application_reasons.has_existing_court_order.details.answer).to eq(answer)
end

And(/^I should see the case number of the court order is "([^"]*)"$/) do |arg|
  expect(cya_page.application_reasons.has_existing_court_order.case_number.answer).to eq(arg)
end

And(/^I should see the expiry date of the court order is "([^"]*)"$/) do |arg|
  expect(cya_page.application_reasons.has_existing_court_order.expiry_date.answer).to eq(arg)
end

And(/^I should see they "(have|haven't)" uploaded their existing court order$/) do |arg|
  if arg == 'have'
    expect(cya_page.application_reasons.existing_court_order_uploadable.answer).to eq('Yes')
    expect(cya_page.application_reasons.existing_court_order_upload.answer).to eq("Attached document\nimage.jpg")
  elsif arg == "haven't"
    expect(cya_page.application_reasons.existing_court_order_uploadable.answer).to eq('No')
  end
end

And(/^I should see there "(are|aren't)" factors that may affect any adult in this application taking part in the court proceedings$/) do |arg|
  answer = (arg == 'are' ? 'Yes' : 'No')
  expect(cya_page.litigation_capacity.reduced_litigation_capacity.answer).to eq(answer)
end

And(/^I should see there "(are|aren't)" people who need an intermediary to help them in court$/) do |arg|
  answer = (arg == 'are' ? 'Yes' : 'No')
  expect(cya_page.attending_court.requires_intermediary_help.answer).to eq(answer)
end

And(/^I should see the details provided for the intermediary are "([^"]*)"$/) do |arg|
  expect(cya_page.attending_court.intermediary_help_details.answer).to eq(arg)
end

And(/^I should see there "(are|aren't)" special language requirements$/) do |arg|
  answer = (arg == 'are' ? 'Yes' : "Not needed")
  expect(cya_page.attending_court.language_requirements.interpreter.answer).to eq(answer)
  expect(cya_page.attending_court.language_requirements.sign_language_interpreter.answer).to eq(answer)
  expect(cya_page.attending_court.language_requirements.welsh_language.answer).to eq(answer)
end

And(/^I should see that an interpreter is needed for the court because "([^"]*)"$/) do |arg|
  expect(cya_page.attending_court.language_requirements.interpreter.answer).to eq('Yes')
  expect(cya_page.attending_court.language_requirements.interpreter_details.answer).to eq(arg)
  expect(cya_page.attending_court.language_requirements.sign_language_interpreter.answer).to eq('Not needed')
  expect(cya_page.attending_court.language_requirements.welsh_language.answer).to eq('Not needed')
end

And(/^I should see a Welsh language interpreter is needed for the court because "([^"]*)"$/) do |arg|
  expect(cya_page.attending_court.language_requirements.interpreter.answer).to eq('Not needed')
  expect(cya_page.attending_court.language_requirements.sign_language_interpreter.answer).to eq('Not needed')
  expect(cya_page.attending_court.language_requirements.welsh_language.answer).to eq('Yes')
  expect(cya_page.attending_court.language_requirements.welsh_language_details.answer).to eq(arg)
end

And(/^I should see there "(are|aren't)" specific safety arrangements specified for the court$/) do |arg|
  if arg == "aren't"
    expect(cya_page.attending_court.safety_arrangements).to have_no_arrangements
    expect(cya_page.attending_court.safety_arrangements.details.answer).to eq("None selected")
  elsif arg == 'are'
    expect(cya_page.attending_court.safety_arrangements).to have_arrangements
  end
end

And(/^I should see there "(are|aren't)" special facilities needed when attending court$/) do |arg|
  if arg == "aren't"
    expect(cya_page.attending_court.special_assistance).to have_no_additional_details
    expect(cya_page.attending_court.special_assistance.details.answer).to eq("None selected")
  elsif arg == 'are'
    expect(cya_page.attending_court.special_assistance).to have_additional_details
  end
end

And(/^I should see the email for submitting an application to court is "([^"]*)"$/) do |arg|
  expect(cya_page.submission.email.answer).to eq(arg)
end

And(/^I should see the payment type "([^"]*)"$/) do |arg|
  expect(cya_page.payment.payment_method.type.answer).to eq(arg)
end

And(/^I should see the HwF reference number is "([^"]*)"$/) do |arg|
  expect(cya_page.payment.payment_method.hwf_ref_no.answer).to eq(arg)
end

Then(/^I should see the statement of truth$/) do
  expect(cya_page.statement_of_truth).to be_visible
end

And(/^I complete the statement of truth as an applicant "([^"]*)"$/) do |name|
  cya_page.complete_statement_of_truth_as_applicant(name)
end

And(/^I complete the declaration as an applicant/) do
  cya_page.complete_declaration_as_applicant
end

And(/^I complete the statement of truth as an representative "([^"]*)"$/) do |name|
  cya_page.complete_statement_of_truth_as_representative(name)
end

And(/^I complete the declaration as an representative/) do
  cya_page.complete_declaration_as_representative
end

When(/^I submit the application$/) do
  cya_page.content.submit_application.click
end

Then(/^I should be taken to the completion confirmation page$/) do
  expect(completion_confirmation_page).to be_displayed
  expect(completion_confirmation_page.content).to have_header
  expect(completion_confirmation_page.content).to have_header
  expect(completion_confirmation_page.content).to have_download_button
end

And(/^I should see the other party is "([^"]*)" years of age$/) do |age|
  expect(cya_page.other_parties_details.personal_details[0].dob).to eq(get_birthdate(age))
end

And(/^I should see they have got a valid exemption: "([^"]*)"$/) do |arg|
  expect(cya_page.miam_exemptions.exemptions_misc.answer).to eq(arg)
end

And(/^I should see the details provided for the exemption are "([^"]*)"$/) do |arg|
  expect(cya_page.miam_exemptions.exemption_details.answer).to eq(arg)
end

And(/^I should see an attachment presenting MIAM exemption evidence "(is|isn't)" present$/) do |arg|
  if arg == 'is'
    expect(cya_page.miam_exemptions.exemption.answer).to eq("Attached document\nimage.jpg")
  elsif arg == "isn't"
    expect(cya_page.miam_exemptions.exemption.answer).to eq("")
  end
end

Then(/^I should be taken to the Check Your Answers page$/) do
  expect(cya_page).to be_displayed
  expect(cya_page.content).to have_header
end

Then(/^I should see the MIAM evidence exemption error message$/) do
  expect(cya_page.miam_evidence_errors).to have_error_message
end

When(/^I click on the MIAM evidence exemption missing information link$/) do
  cya_page.miam_evidence_errors.missing_info_link.click
end

And(/^I should see that all alternatives "(have|haven't)" been tried$/) do |arg|
  answer = (arg == 'have' ? 'Yes' : 'No')
  expect(cya_page.alternatives.alternative_negotiation_tools.answer).to eq(answer)
  expect(cya_page.alternatives.alternative_mediation.answer).to eq(answer)
  expect(cya_page.alternatives.alternative_lawyer_negotiation.answer).to eq(answer)
  expect(cya_page.alternatives.alternative_collaborative_law.answer).to eq(answer)
end

And(/^I should see the children details:$/) do |table|
  answer_children = table.hashes

  expect(cya_page.children_details.children.count).to eq(answer_children.size)

  answer_children.each_with_index do |child_data, i|
    expect(cya_page.children_details.full_name[i].answer).to eq(child_data['full_name'])
    expect(cya_page.children_details.personal_details[i].dob).to eq(get_birthdate(child_data['age']))
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
    expect(cya_page.applicants_details.personal_details[i].dob).to eq(get_birthdate(applicant_data['age']))
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
    expect(cya_page.respondents_details.personal_details[i].dob).to eq(get_birthdate(respondents_data['age']))
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

  answer_proceedings.each_with_index do |proceeding_data, _i|
    expect(cya_page.other_court_cases.details.children_names.answer).to eq(proceeding_data['child_name'])
    expect(cya_page.other_court_cases.details.court_name.answer).to eq(proceeding_data['court_name'])
    expect(cya_page.other_court_cases.details.proceedings_date.answer).to eq(proceeding_data['date'])
    expect(cya_page.other_court_cases.details.order_types.answer).to eq(proceeding_data['order_type'])
    expect(cya_page.other_court_cases.details.previous_details.answer).to eq(proceeding_data['previous_details'])
  end
end
