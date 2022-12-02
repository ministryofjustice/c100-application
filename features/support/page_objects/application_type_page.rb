class ApplicationTypePage < BasePage
  set_url '/steps/opening/consent_order'

  section :content, '#main-content' do
    element :header, 'h1', text: 'What kind of application do you want to make?'
  end

end
