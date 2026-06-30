class AbuseConcernsApplicantPsychologicalDetailsPage < SafetyConcernDetailsPage
  set_url '/steps/abuse_concerns/details/applicant/psychological'

  section :content, '#main-content' do
    element :header, 'h1', text: 'About the psychological abuse'
  end
end
