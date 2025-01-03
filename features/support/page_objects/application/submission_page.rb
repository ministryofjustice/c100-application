class SubmissionPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/application/submission'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Submitting your application to court'
    element :subheader, 'p', text: 'Your completed application will be sent to the court electronically.'
    element :label, 'label', text: 'Enter an email address if you would like to get a confirmation'
    element :hint, 'div', text: 'You can also download a copy on the confirmation page.'

    element :continue_button, 'button', text: 'Continue'
  end
end
