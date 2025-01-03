class NamesPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/respondent/names'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Enter the respondent’s name'
    element :inset_text, 'div', text: 'The other people who will receive this application are known as the respondents.'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
    element :legend, 'span', text: 'Enter a new name'
    element :first_name, 'label', text: 'First name(s)'
    element :last_name, 'label', text: 'Last name(s)'
    element :another_respondent, 'button', text: 'Add another respondent'

    element :continue_button, 'button', text: 'Continue'
  end
end
