class AbuseConcernsApplicantOtherPage < YesNoPage
  set_url '/steps/abuse_concerns/question/applicant/other'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Do you have any other concerns about your welfare?'
  end
end