class AbuseConcernsApplicantEmotionalDetailsPage < SafetyConcernDetailsPage
  set_url '/steps/abuse_concerns/details/applicant/emotional'

  section :content, '#main-content' do
    element :header, 'h1', text: 'About the emotional abuse'
  end
end
