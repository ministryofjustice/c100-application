class PreviousProceedingsPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/application/previous_proceedings'

  section :content, '#main-content' do
    element :caption, 'span', text: 'Previous proceedings'
    element :header, 'h1', text: 'Have any of the children in this application been involved in other family court proceedings?'
    element :subheader, 'p', text: 'For example an emergency protection order or supervision order. Include any ongoing cases.'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'

    element :continue_button, 'button', text: 'Continue'
  end
end
