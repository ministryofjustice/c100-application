class ProtectionPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/petition/protection'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Is there anything else you are asking the court to decide, specifically to protect the safety of you or the children?'
    element :subheader, 'p', text: 'This can include:'
    element :ul_1, 'ul', text: 'that the person must not be violent or threaten or harass by any means (Non-Molestation Order)'
    element :ul_2, 'ul', text: 'preventing a person doing a particular action (Prohibited Steps Order)'
    element :ul_3, 'ul', text: 'making a decision about a specific issue on which you and the other person can’t decide (Specific Issue Order)'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'

    element :continue_button, 'button', text: 'Continue'
  end
end
