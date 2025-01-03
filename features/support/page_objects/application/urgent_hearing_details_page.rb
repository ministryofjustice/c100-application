class UrgentHearingDetailsPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/application/urgent_hearing_details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Details of urgent hearing'
    element :label_1, 'label', text: 'Give details of why you’re asking for an urgent hearing'
    element :hint, 'div', text: 'A court will only hear your case urgently if you can give good reason for the urgency.'
    element :label_2, 'label', text: 'How soon do you need an urgent hearing?'
    element :inset_text, 'div', text: 'If you need to go to court now, contact your nearest family court for assistance.'
    element :link, 'a', text: 'contact your nearest family court'
    element :legend, 'span', text: 'Do you need a hearing within the next 48 hours?'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'

    element :continue_button, 'button', text: 'Continue'
  end
end
