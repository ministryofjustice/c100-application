class PostcodePage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/opening/postcode'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Where do the children live?'
    element :subheader, 'p', text: 'Please tell us the postcode of the children you’re making this application about.'
    element :postcode, 'label', text: 'Postcode'
    element :span, 'span', text: 'If you do not know where the children live'
    element :inset_text, 'div', text: 'If you do not know the children’s postcode please enter your own.'

    element :continue_button, 'button', text: 'Continue'
  end
end
