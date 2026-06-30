class MiamCertificationPage < YesNoPage
  set_url '/steps/miam/certification'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have you got a document signed by the mediator?'
  end
end
