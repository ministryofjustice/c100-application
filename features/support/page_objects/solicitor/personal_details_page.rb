class PersonalDetailsPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/solicitor/personal_details'

  section :content, '#content' do
    element :header, 'h1', text: 'Details of solicitor'
    element :subheader, 'p', text: 'This is the person who’s been instructed to act in these proceedings.'
    element :full_name, 'label', text: 'Full name'
    element :firm_name, 'label', text: 'Name of firm'
    element :reference, 'label', text: 'Solicitor’s reference'
    element :reference_hint, '.govuk-hint', text: 'This is the reference for this case'

    element :continue_button, 'button', text: 'Continue'
  end
end
