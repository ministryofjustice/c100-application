class CourtProceedingsPage < BasePage
  set_url '/steps/applicant/court_proceedings'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Contact details of'
  end

  def submit_contact_details(email:, phone:, voicemail_consent:)
    content.email_provided_yes.click
    content.email_field.set email
    content.phone_number_provided_yes.click
    content.phone_number_field.set phone

    if voicemail_consent == 'yes'
      content.voicemail_consent_yes.click
    else
      content.voicemail_consent_no.click
    end

    click_continue_button
  end

  def continue_without_filling
    click_continue_button
  end
end
