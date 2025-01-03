class PersonalDetailsPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/other_party/refuge'

  section :content, '#main-content' do
    element :header, 'h1', text: /Provide details for .*?/
    element :legend_1, 'span', text: 'Date of birth'
    element :hint, 'div', text: 'For example, 31 3 2016'
    element :day, 'label', text: 'Day'
    element :month, 'label', text: 'Month'
    element :year, 'label', text: 'Year'
    element :not_known, 'label', text: 'I don’t know their date of birth'
    element :legend_2, 'span', text: 'Sex'
    element :female, 'label', text: 'Female'
    element :male, 'label', text: 'Male'
    element :unspecified, 'label', text: 'Unspecified'

    element :continue_button, 'button', text: 'Continue'
  end
end
