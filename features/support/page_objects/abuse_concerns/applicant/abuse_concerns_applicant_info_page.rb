class AbuseConcernsApplicantInfoPage < BasePage
  set_url '/steps/abuse_concerns/applicant_info'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Your safety'
  end
end
