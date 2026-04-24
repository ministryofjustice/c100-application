class AbuseConcernsApplicantQuestionPage < YesNoPage
  set_url '/steps/abuse_concerns/question?subject=applicant'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have you ever been sexually abused by the respondent?'
  end
end