class CertificationPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/miam/certification'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have you got a document signed by the mediator?'
    element :p_1, 'p', text: 'The mediator should provide you with a signed document to confirm you attended a MIAM. If you haven’t got a document, you should ask the mediator for one.'
    element :p_2, 'p', text: 'This evidence must be provided to the court with your application.'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'

    element :continue_button, 'button', text: 'Continue'
  end
end
