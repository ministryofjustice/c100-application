class SafetyConcernPage < BasePage
  set_url '/steps/safety_questions/start'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Safety concerns'
  end
end
