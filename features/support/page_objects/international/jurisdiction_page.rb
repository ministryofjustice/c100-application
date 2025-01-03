class JurisdictionPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/international/jurisdiction'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Do you think another person in this application may be able to apply for a similar order in a country outside England or Wales?'
    element :hint, 'div', text: 'For example, because a court in another country has the power to act (has jurisdiction).'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'

    element :continue_button, 'button', text: 'Continue'
  end
end
