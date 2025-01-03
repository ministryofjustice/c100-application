class SignInOrCreateAccountPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/opening/sign_in_or_create_account'

  section :content, '#main-content' do
    element :header_1, 'h1', text: 'Sign in or create account'
    element :subheader, 'h2', text: 'Access the MyHMCTS case management tool for legal professionals.'
    element :header_2, 'h1', text: 'Do you have a MyHMCTS account?'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
    element :hint_1, 'label', text: 'Sign in to your account'
    element :hint_2, 'label', text: 'Create a new account'

    element :continue_button, 'button', text: 'Continue'
  end
end
