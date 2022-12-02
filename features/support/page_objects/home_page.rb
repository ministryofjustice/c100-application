class HomePage < BasePage
  set_url '/'

  section :content, '#main-content' do
    element :header, 'h1', text: 'What you’ll need to complete your application'
    element :needs, 'p', text: 'You will need the following:'
    element :continue, '.govuk-button', text: 'Continue'
    element :sign_in, 'a', text: 'Or return to a saved application'
    element :back, 'a', 'https://www.gov.uk/looking-after-children-divorce/apply-for-court-order'
  end

end

