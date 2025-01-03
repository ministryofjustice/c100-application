class ContactDetailsPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/solicitor/contact_details'

  section :content, '#content' do
    element :header, 'h1', text: 'Contact details of '
    element :email, 'label', text: 'Email address'
    element :phone_number, 'label', text: 'Phone number'
    element :dx_number, 'label', text: 'DX number'
    element :dx_number_hint, '.govuk-hint', text: 'This is a secure document exchange system used by the legal profession'

    element :continue_button, 'button', text: 'Continue'
  end
end
