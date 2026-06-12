class AbuseConcernsApplicantPsychologicalPage < YesNoPage
  set_url '/steps/abuse_concerns/question/applicant/psychological'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have you ever been psychologically abused by the respondent?'
  end
end