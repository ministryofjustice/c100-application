class SubstanceAbusePage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/safety_questions/substance_abuse'

  section :content, '#content' do
    element :legend, 'span', text: 'Safety concerns'
    element :header, 'h1', text: 'Do you have any concerns about drug, alcohol or substance abuse?'
    element :subheader, 'p', text: 'For example, you think the children are affected by being in contact with someone who may have a drug, alcohol or substance problem.'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
    element :details, 'label', text: 'Give a short description of the drug, alcohol or substance abuse'

    element :continue_button, 'button', text: 'Continue'
  end
end
