class AbuseConcernsApplicantOtherDetailsPage < SafetyConcernDetailsPage
  set_url '/steps/abuse_concerns/details/applicant/other'

  section :content, '#main-content' do
    element :header, 'h1', text: 'About the other abuse'
  end
end