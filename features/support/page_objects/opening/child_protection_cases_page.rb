class ChildProtectionCasesPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/opening/child_protection_cases'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Does this application concern a child who is the subject of separate ongoing emergency proceedings, care proceedings or supervision proceedings (or is already the subject of an emergency, care or supervision order)?'
    element :subheader, 'p', text: 'These will usually involve a local authority.'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'

    element :continue_button, 'button', text: 'Continue'
  end
end
