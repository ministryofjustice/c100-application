class ApplicantRefugePage < YesNoPage
  set_url '/steps/applicant/refuge'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Are you currently resident in a refuge?'
  end
end
