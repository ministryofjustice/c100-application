class AbuseConcernsApplicantPhysicalDetailsPage < SafetyConcernDetailsPage
  set_url '/steps/abuse_concerns/details/applicant/physical'

  section :content, '#main-content' do
    element :header, 'h1', text: 'About the physical abuse'
  end
end
