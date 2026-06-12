class AbductionPreviousAttemptPage < YesNoPage
  set_url '/steps/abduction/previous_attempt'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have the children been abducted or kept outside the UK without your consent before?'
  end
end