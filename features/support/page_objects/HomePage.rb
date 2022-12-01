class HomePage < BasePage
  set_url '/'

  section :content, '#main-content' do
    element :header, 'h1', text: 'What you’ll need to complete your application'
    element :needs, 'p', text: 'You will need the following:'
  end
end

