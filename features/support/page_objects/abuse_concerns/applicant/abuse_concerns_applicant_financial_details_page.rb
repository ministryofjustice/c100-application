class AbuseConcernsApplicantFinancialDetailsPage < SafetyConcernDetailsPage
  set_url '/steps/abuse_concerns/details/applicant/financial'

  section :content, '#main-content' do
    element :header, 'h1', text: 'About the financial abuse'
  end
end
