class PassportDetailsPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/abduction/passport_details'

  section :content, '#main-content' do
    element :caption, 'span', text: 'Safety concerns'
    element :header, 'h1', text: 'Provide details of the children’s passports'
    element :legend_1, 'span', text: 'Do the children have more than one passport?'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
    element :legend_2, 'span', text: 'Who is in possession of the children’s passports?'
    element :hint, 'div', text: 'Select all that apply'
    element :label_1, 'label', text: 'Mother'
    element :label_2, 'label', text: 'Father'
    element :label_3, 'label', text: 'Other'

    element :continue_button, 'button', text: 'Continue'
  end
end
