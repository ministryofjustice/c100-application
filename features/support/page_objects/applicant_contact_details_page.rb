class ApplicantContactDetailsPage < BasePage
  set_url '/steps/applicant/contact_details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Contact details of'
    element :email_provided_yes, "input#steps-applicant-contact-details-form-email-provided-yes-field", visible: false
    element :email_provided_no, "input#steps-applicant-contact-details-form-email-provided-no-field", visible: false
    element :email_field, "input[name='steps_applicant_contact_details_form[email]']"
    element :phone_number_provided_yes, "input#steps-applicant-contact-details-form-phone-number-provided-yes-field", visible: false
    element :phone_number_provided_no, "input#steps-applicant-contact-details-form-phone-number-provided-no-field", visible: false
    element :phone_number_field, "input[name='steps_applicant_contact_details_form[phone_number]']"
    element :voicemail_consent_yes, "input#steps-applicant-contact-details-form-voicemail-consent-yes-field", visible: false
    element :voicemail_consent_no, "input#steps-applicant-contact-details-form-voicemail-consent-no-field", visible: false
    element :continue_button, "button", text: "Continue"
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
    
    content.continue_button.click
  end

  def continue_without_filling
    content.continue_button.click
  end
end