class IntermediaryPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/attending_court/intermediary'

  section :content, '#main-content' do
    element :caption, 'span', text: 'Attending court'
    element :header, 'h1', text: 'Does anyone in this application need an intermediary to help them in court?'
    element :hint, 'div', text: 'An intermediary is appointed by the court to help people participate in court. For example, you may need an intermediary if you have a learning, mental or physical disability.'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'

    element :continue_button, 'button', text: 'Continue'
  end
end
