class MiamPage < BasePage
  set_url '/steps/opening/child_protection_info'

  section :content, '#main-content' do
    element :header, 'h1', text: 'MIAM'
  end
end
