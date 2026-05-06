class AbuseConcernsPsychologicalPage < YesNoPage
  set_url '/steps/abuse_concerns/question/children/psychological'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have the children ever been psychologically abused by the respondent?'
  end
end