class AlternativePage < BasePage
  set_url '/steps/alternatives/start'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Alternative ways to reach an agreement'
    element :continue_button, "a", text: "Continue"
  end

  def continue_to_next_step
    content.continue_button.click
  end
end