class AbuseConcernsPage < BasePage
  set_url '/steps/abuse_concerns/start'

  section :content, '#main-content' do
    element :header, 'h1', text: 'You and the children'
    element :continue_button, "a", text: "Continue"
  end

  def continue_to_next_step
    content.continue_button.click
  end
end