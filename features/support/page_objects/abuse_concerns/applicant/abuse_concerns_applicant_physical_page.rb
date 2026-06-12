class AbuseConcernsApplicantPhysicalPage < YesNoPage
  set_url '/steps/abuse_concerns/question/applicant/physical'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have you ever been physically abused by the respondent?'
  end
end