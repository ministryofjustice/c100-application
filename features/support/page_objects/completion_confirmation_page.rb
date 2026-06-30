class CompletionConfirmationPage < BasePage
  set_url '/steps/completion/confirmation'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Your application has been submitted'
    element :download_button, 'a', text: 'Download your application'
  end
end
