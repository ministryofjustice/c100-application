class PersonalDetailsPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/applicant/personal_details'

  section :content, '#main-content' do
    element :header, 'h1', text: /Provide details for .*?/
    element :legend_1, 'span', text: 'Have you changed your name?'
    element :hint_1, 'div', text: 'For example, through marriage or adoption or by deed poll. This includes first name, surname and any middle names'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
    element :legend_2, 'span', text: 'Sex'
    element :female, 'label', text: 'Female'
    element :male, 'label', text: 'Male'
    element :unspecified, 'label', text: 'Unspecified'
    element :legend_3, 'span', text: 'Your date of birth'
    element :hint_2, 'div', text: 'For example, 31 3 2016'
    element :day, 'Day'
    element :month, 'Month'
    element :year, 'Year'
    element :legend_4, 'span', text: 'Your place of birth'
    element :hint_3, 'div', text: 'For example, town or city'

    element :continue_button, 'button', text: 'Continue'
  end
end
