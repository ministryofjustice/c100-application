class ChildProtectionInfoPage < BasePage
  set_url '/steps/opening/child_protection_info'

  section :content, '#main-content' do
    element :header, 'h1', text: 'You do not have to attend a MIAM'
    element :continue_button, "a", text: "Continue"
  end

  def continue_to_next_step
    content.continue_button.click
  end
end