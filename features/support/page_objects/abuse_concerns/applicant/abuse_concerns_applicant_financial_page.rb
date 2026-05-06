class AbuseConcernsApplicantFinancialPage < YesNoPage
  set_url '/steps/abuse_concerns/question/applicant/financial'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have you ever been financially abused by the respondent?'
  end
end