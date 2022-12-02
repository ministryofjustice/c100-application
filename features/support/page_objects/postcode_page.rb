class PostcodePage < BasePage
  set_url '/steps/opening/postcode'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Where do the children live?'
    element :entry, '.govuk-input', text: ''
    element :dropdown, '.govuk-details__summary-text', text: 'If you do not know where the children live'
    element :dropdown_text, '.govuk-details__text', text: 'If you do not know the children’s postcode please enter your own.'
    element :error, '.govuk-error-message', text: 'Enter a full postcode, with or without a space'
    element :error_title, 'h2', text: 'There is a problem on this page'
    element :error_message, 'a', text: 'Enter a full postcode, with or without a space'
    element :error_invalid, '.govuk-error-message', text: 'Enter a valid full postcode, with or without a space'
    element :error_message_invalid, 'a', text: 'Enter a valid full postcode, with or without a space'
  end
end

