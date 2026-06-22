class SubmissionPage < BasePage
  set_url '/steps/application/submission'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Submitting your application to court'
    element :receipt_email_input, 'input[name="steps_application_submission_form[receipt_email]"]'
  end

  def submit_receipt_email(email)
    content.receipt_email_input.set email
    click_continue_button
  end

  def continue_without_filling
    click_continue_button
  end
end
