class AbuseConcernsApplicantQuestionDetailsPage < SafetyConcernDetailsPage
  set_url '/steps/abuse_concerns/details/applicant/sexual'

  section :content, '#main-content' do
    element :header, 'h1', text: 'About the sexual abuse'
  end
end