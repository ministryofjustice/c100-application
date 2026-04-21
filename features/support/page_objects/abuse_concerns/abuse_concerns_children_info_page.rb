class AbuseConcernsChildrenInfoPage < BasePage
  set_url '/steps/abuse_concerns/children_info'

  section :content, '#main-content' do
    element :header, 'h1', text: 'The children’s safety'
    element :continue_button, "a", text: "Continue"
  end

  def continue_to_next_step
    content.continue_button.click
  end
end