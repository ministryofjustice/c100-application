class AbuseConcernsQuestionPage < YesNoPage
  set_url '/steps/abuse_concerns/question'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have the children ever been sexually abused by the respondent?'
  end
end