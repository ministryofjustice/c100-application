class PermissionSoughtPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/application/permission_sought'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have you already applied to the court for permission to make this application?'
    element :subheader, 'p', text: 'You may already have permission from the court, or applied for permission separately. If not, you will be able to apply as part of this application.'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'

    element :continue_button, 'button', text: 'Continue'
  end
end
