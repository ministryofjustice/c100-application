class ApplicantPrivacyKnownPage < BasePage
  set_url '/steps/applicant/privacy_known'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Do the other people named in this application (the respondents) know any of your contact details?'
    element :answer_yes, "input[name='steps_applicant_privacy_known_form[privacy_known]'][value='yes']", visible: false
    element :answer_no, "input#steps-applicant-privacy-known-form-privacy-known-no-field", visible: false
    element :continue_button, "button", text: "Continue"
  end

  def submit_yes
    content.answer_yes.click
    content.continue_button.click
  end

  def submit_no
    content.answer_no.click
    content.continue_button.click
  end

  def submit(answer)
    if answer == 'yes'
      submit_yes
    else
      submit_no
    end
  end

  def continue_without_selecting
    content.continue_button.click
  end
end