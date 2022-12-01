class SignInPage < BasePage
  set_url '/steps/opening/postcode'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Sign in'
  end
end

