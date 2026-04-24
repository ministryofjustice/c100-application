class ApplicantPrivacyPreferencesPage < BasePage
  set_url '/steps/applicant/privacy_preferences'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Do you want to keep your contact details private'
    element :answer_yes, "input#steps-applicant-privacy-preferences-form-are-contact-details-private-yes-field", visible: false
    element :answer_no, "input#steps-applicant-privacy-preferences-form-are-contact-details-private-no-field", visible: false
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