class PersonalDetailsPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/other_party/personal_details'

  section :content, '#main-content' do
    element :header, 'h1', text: /Provide details for .*?/
    element :legend_1, 'span', text: 'Have they changed their name?'
    element :hint, 'div', text: 'For example, through marriage or adoption or by deed poll. This includes first name, surname and any middle names'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
    element :not_known_1, 'label', text: 'Don\'t know'
    element :legend_2, 'span', text: 'Sex'
    element :female, 'label', text: 'Female'
    element :male, 'label', text: 'Male'
    element :unspecified, 'label', text: 'Unspecified'
    element :legend_3, 'span', text: 'Date of birth'
    element :day, 'label', text: 'Day'
    element :month, 'label', text: 'Month'
    element :year, 'label', text: 'Year'
    element :not_known_2, 'label', text: 'I don’t know their date of birth'

    element :continue_button, 'button', text: 'Continue'
  end
end
