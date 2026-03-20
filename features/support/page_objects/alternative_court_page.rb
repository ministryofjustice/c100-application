class AlternativeCourtPage < BasePage
  set_url '/steps/alternatives/court'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Going to court'
    element :acknowledgement, 'input#steps-alternatives-court-form-court-acknowledgement-true-field', visible: false
    element :continue_button, "button", text: "Continue"
  end

  def acknowledge_and_continue
    content.acknowledgement.click
    content.continue_button.click
  end
end