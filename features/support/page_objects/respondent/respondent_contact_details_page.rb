class RespondentContactDetailsPage < BasePage
  set_url_matcher %r{/steps/respondent/contact_details/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'Contact details of'
    element :email_field, "input#steps-respondent-contact-details-form-email-field"
    element :email_unknown_checkbox, "input#steps-respondent-contact-details-form-email-unknown-true-field", visible: false
    element :phone_number_field, "input#steps-respondent-contact-details-form-phone-number-field"
    element :phone_number_unknown_checkbox, "input#steps-respondent-contact-details-form-phone-number-unknown-true-field", visible: false
    element :continue_button, "button", text: "Continue"
  end

  def submit_contact_details(email:, phone:)
    content.email_field.set email
    content.phone_number_field.set phone
    
    content.continue_button.click
  end
end