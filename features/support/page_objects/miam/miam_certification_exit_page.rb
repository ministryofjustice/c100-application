class MiamCertificationExitPage < BasePage
  set_url '/steps/miam/certification_exit'

  section :content, '#main-content' do
    element :header, 'h1', text: 'You need to get a document from the mediator'
  end
end