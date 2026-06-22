class SafetyConcernPage < BasePage
  set_url '/steps/safety_questions/start'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Safety concerns'
  end

  def continue_to_next_step
    click_continue_link
  end
end
