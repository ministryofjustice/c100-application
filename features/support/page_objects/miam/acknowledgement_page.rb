class AcknowledgementPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/miam/acknowledgement'

  section :content, '#main-content' do
    element :header_1, 'h1', text: 'Attending a Mediation Information and Assessment Meeting (MIAM)'
    element :p_1, 'p', text: 'Before completing this application you’re legally required to attend a Mediation Information and Assessment Meeting (MIAM), unless you’re exempt.'
    element :link_1, 'a', text: ' you’re exempt'
    element :p_2, 'p', text: 'A MIAM is an initial meeting where you\'ll be given information about mediation and other kinds of non-court dispute resolution. A mediator will explore whether these other options are suitable in your case.'
    element :link_2, 'a', text: 'mediation'
    element :p_3, 'p', text: ' Non court dispute resolution, or NCDR, means methods of resolving a dispute other than through the court process, including but not limited to mediation, arbitration, evaluation by a neutral third party (such as a private Financial Dispute Resolution process) and collaborative law.'
    element :link_3, 'a', text: 'Check if you’re eligible for legal aid during mediation'
    element :inset_text, 'div', text: 'A MIAM is a one-off meeting and not the same as mediation.'
    element :header_2, 'h2', text: 'What happens at a MIAM'
    element :p_4, 'p', text: 'At the MIAM a mediator will explain:'
    element :li_1, 'li', text: 'how mediation works'
    element :li_2, 'li', text: 'the benefits of mediation'
    element :li_3, 'li', text: 'whether mediation is right for you'
    element :li_4, 'li', text: 'the likely costs'
    element :li_5, 'li', text: 'if you may qualify for help with the costs of mediation and legal advice'
    element :li_6, 'li', text: 'other options you could use to help you reach an agreement'
    element :link_4, 'a', text: 'Find a mediator to book a MIAM'
    element :header_3, 'h2', text: 'If you’ve already attended a MIAM'
    element :p_5, 'p', text: 'You should have a document signed by the mediator confirming this. You need to submit a copy of this document with this application to court.'
    element :header_4, 'h1', text: 'Have you previously been to mediation through the mediation voucher scheme?'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
    element :header_5, 'h2', text: 'When you don’t have to attend a MIAM'
    element :p_6, 'p', text: 'You don’t have to attend a MIAM if you have a valid reason. For example you or the children are at risk of harm.'
    element :link_5, 'a', text: 'List of valid reasons for not attending a MIAM'
    element :legend, 'span', text: 'Attending a MIAM'
    element :label, 'label', text: 'I understand that I have to attend a MIAM, or a non-court dispute resolution process, or provide a valid reason for not attending.'

    element :continue_button, 'button', text: 'Continue'
  end
end
