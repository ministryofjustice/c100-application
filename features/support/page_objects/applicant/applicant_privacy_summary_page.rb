class ApplicantPrivacySummaryPage < BasePage
  set_url_matcher %r{/steps/applicant/privacy_summary/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'The court will not keep your contact details private'
    element :continue_button, "a", text: "Continue"
  end

  def continue_to_next_step
    content.continue_button.click
  end
end