class SafetyConcernPage < BasePage
  set_url '/steps/safety_questions/start'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Safety concerns'
    element :continue_button, "a", text: "Continue"
  end

  def continue_to_next_step
    content.continue_button.click
  end
end