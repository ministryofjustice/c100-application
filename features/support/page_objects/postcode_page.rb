class PostcodePage < BasePage
  set_url '/steps/opening/postcode'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Where do the children live?'
  end
end

