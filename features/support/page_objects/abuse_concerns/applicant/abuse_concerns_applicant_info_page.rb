class AbuseConcernsApplicantInfoPage < BasePage
  set_url '/steps/abuse_concerns/applicant_info'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Your safety'
    element :continue_button, "a", text: "Continue"
  end

  def continue_to_next_step
    content.continue_button.click
  end
end