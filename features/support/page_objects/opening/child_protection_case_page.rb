class ChildProtectionCasePage < BasePage
  set_url '/steps/opening/child_protection_cases'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Does this application concern a child who is the subject of separate ongoing emergency proceedings, care proceedings or supervision proceedings (or is already the subject of an emergency, care or supervision order)?'
    element :answer_yes, "input#steps-opening-child-protection-cases-form-child-protection-cases-yes-field", visible: false
    element :answer_no, "input#steps-opening-child-protection-cases-form-child-protection-cases-no-field", visible: false
    element :continue_button, "button", text: "Continue"
  end

  def continue_to_next_step
    content.continue.click
  end

  def submit_yes
    content.answer_yes.click
    content.continue_button.click
  end

  def submit_no
    content.answer_no.click
    content.continue_button.click
  end
end