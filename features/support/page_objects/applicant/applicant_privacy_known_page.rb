class ApplicantPrivacyKnownPage < YesNoPage
  set_url '/steps/applicant/privacy_known'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Do the other people named in this application (the respondents) know any of your contact details?'
    element :answer_dont_know, "input[name='steps_applicant_privacy_known_form[privacy_known]'][value='unknown']", visible: false
  end

  def submit_dont_know
    content.answer_dont_know.click
    click_continue_button
  end
end
