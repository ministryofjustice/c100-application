class AbuseConcernsPhysicalPage < YesNoPage
  set_url '/steps/abuse_concerns/question/children/physical'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have the children ever been physically abused by the respondent?'
  end
end