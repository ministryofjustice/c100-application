class ChildrenHavePassportPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/abduction/children_have_passport'

  section :content, '#main-content' do
    element :caption, 'span', text: 'Safety concerns'
    element :header, 'h1', text: 'Do any of the children have a passport?'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'

    element :continue_button, 'button', text: 'Continue'
  end
end
