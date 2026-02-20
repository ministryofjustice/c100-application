class SolicitorContactDetailsPage < BasePage
  set_url '/steps/solicitor/contact_details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Contact details of'
    element :email_field, "input[name='steps_solicitor_contact_details_form[email]']"
    element :phone_number_field, "input[name='steps_solicitor_contact_details_form[phone_number]']"
    element :dx_number_field, "input[name='steps_solicitor_contact_details_form[dx_number]']"
    element :continue_button, "button", text: "Continue"
  end

  def submit_contact_details(email, phone, dx_number)
    content.email_field.set email
    content.phone_number_field.set phone
    content.dx_number_field.set dx_number
    content.continue_button.click
  end

  def continue_without_filling
    content.continue_button.click
  end
end