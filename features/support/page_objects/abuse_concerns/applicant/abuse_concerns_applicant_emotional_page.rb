class AbuseConcernsApplicantEmotionalPage < YesNoPage
  set_url '/steps/abuse_concerns/question/applicant/emotional'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have you ever been emotionally abused by the respondent?'
  end
end