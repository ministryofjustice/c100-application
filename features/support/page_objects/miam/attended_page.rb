class AttendedPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/miam/attended'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have you attended a Mediation Information and Assessment Meeting (MIAM)?'
    element :p, 'p', text: 'The MIAM must be about the same issue that is being dealt with in this application.'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'

    element :continue_button, 'button', text: 'Continue'
  end
end
