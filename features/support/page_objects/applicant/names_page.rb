class NamesPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/applicant/names'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Enter your name'
    element :inset_text_1, 'p', text: 'You and anyone else making this application are known as the applicants.'
    element :inset_text_2, 'p', text: 'The other people who will receive this application are known as the respondents. We will ask for their details later.'
    element :legend, 'span', text: 'Enter a new name'
    element :label_1, 'label', text: 'First name(s)'
    element :hint, 'div', text: 'Include all middle names here'
    element :label_2, 'label', text: 'Last name(s)'

    element :add_button, 'button', text: 'Add another applicant'
    element :continue_button, 'button', text: 'Continue'
  end
end
