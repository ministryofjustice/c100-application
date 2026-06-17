When(/^I submit that I have a MIAM exemption$/) do
  expect(consent_order_page).to be_displayed
  consent_order_page.submit_without_consent_order

  expect(child_protection_case_page).to be_displayed
  child_protection_case_page.submit_no

  expect(miam_acknowledgement_page).to be_displayed
  miam_acknowledgement_page.submit_voucher_scheme_no

  expect(miam_attended_page).to be_displayed
  miam_attended_page.submit_no

  expect(miam_exemption_claim_page).to be_displayed
  miam_exemption_claim_page.submit_yes

  expect(miam_exemptions_domestic_page).to be_displayed
  miam_exemptions_domestic_page.submit_none_of_these

  expect(miam_exemptions_protection_page).to be_displayed
  miam_exemptions_protection_page.submit_none_of_these

  expect(miam_exemptions_urgency_page).to be_displayed
  miam_exemptions_urgency_page.submit_none_of_these

  expect(miam_exemptions_adr_page).to be_displayed
  miam_exemptions_adr_page.submit_none_of_these

  expect(miam_exemptions_misc_page).to be_displayed
  miam_exemptions_misc_page.submit_without_notice_hearing
end

When(/^I submit that I have attended a MIAM$/) do
  expect(consent_order_page).to be_displayed
  consent_order_page.submit_without_consent_order

  expect(child_protection_case_page).to be_displayed
  child_protection_case_page.submit_no

  expect(miam_acknowledgement_page).to be_displayed
  miam_acknowledgement_page.submit_voucher_scheme_no

  expect(miam_attended_page).to be_displayed
  miam_attended_page.submit_yes
  
  expect(miam_certification_page).to be_displayed
  miam_certification_page.submit_no

  # test unhappy path
  expect(miam_certification_exit_page).to be_displayed
  miam_certification_exit_page.go_back

  expect(miam_certification_page).to be_displayed
  miam_certification_page.submit_yes

  expect(miam_certification_upload_page).to be_displayed
  file_path = File.absolute_path('features/support/sample_file/image.jpg')
  miam_certification_upload_page.upload_file(file_path)
end

When(/^I submit that I have a MIAM with a child protection case$/) do
  expect(consent_order_page).to be_displayed
  consent_order_page.submit_without_consent_order

  expect(child_protection_case_page).to be_displayed
  child_protection_case_page.submit_yes

  expect(child_protection_info_page).to be_displayed
  child_protection_info_page.continue_to_next_step
end

And(/^evidence "(is|isn't)" provided for the MIAM exemption$/) do |arg|
  expect(miam_exemptions_reasons_page).to be_displayed
  if arg == 'is'
    miam_exemptions_reasons_page.submit_yes

    expect(miam_exemptions_exemption_upload_page).to be_displayed
    file_path = File.absolute_path('features/support/sample_file/image.jpg')
    miam_exemptions_exemption_upload_page.upload_file(file_path)

    expect(miam_exemptions_details_page).to be_displayed
    miam_exemptions_details_page.submit_exemption_details('exemption reason')
  else
    miam_exemptions_reasons_page.submit_no_exemption_reasons('Supporting reason')

    expect(miam_exemptions_details_page).to be_displayed
    miam_exemptions_details_page.continue_without_filling
  end

  expect(miam_exemptions_reasons_playback_page).to be_displayed
  miam_exemptions_reasons_playback_page.continue
end