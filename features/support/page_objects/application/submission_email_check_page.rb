class SubmissionEmailCheckPage < BasePage
  set_url '/steps/application/receipt_email_check'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Is this email address correct?'
    element :receipt_email, '.govuk-inset-text'
    element :continue_button, "a", text: "Yes, continue"
  end

  def submit_yes
    content.continue_button.click
  end
end