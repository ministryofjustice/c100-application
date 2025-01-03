class CourtPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/alternatives/court'

  section :content, '#main-content' do
    element :header_1, 'h1', text: 'Going to court'
    element :p_1, 'p', text: 'Before you continue with your application you should consider what the court process might involve and whether you need to go.'
    element :inset_text, 'p', text: 't is often better to agree arrangements for the children outside of court, unless you have safety concerns.'
    element :header_2, 'h2', text: 'What happens at court'
    element :p_2, 'p', text: 'A judge must, by law, put the children first. The court will decide on what it thinks is best for the children. If you apply to court you must be prepared to follow the court’s decision, even if you don’t agree with it.'
    element :p_3, 'p', text: 'The court’s decision will be set out in a ‘court order’ which you must stick to.'
    element :link_1, 'a', text: 'Find out more about going to court'
    element :header_3, 'h2', text: 'Changing or enforcing an order'
    element :p_4, 'p', text: 'A court order is not flexible. You’ll need to apply to court again if your situation changes.'
    element :p_5, 'p', text: 'You or the other people involved can apply to court to enforce the order if any of you is not following the terms.'
    element :header_4, 'h2', text: 'Representing yourself in court'
    element :p_6, 'p', text: 'If you don’t qualify, or can’t afford a lawyer, you will need to learn how to represent yourself in court before you apply.'
    element :link_2, 'a', text: 'how to represent yourself in court'
    element :header_5, 'h2', text: 'Domestic abuse and child abuse'
    element :p_7, 'p', text: 'You might be able to get legal aid if you have evidence that you or the children have been victims of abuse.'
    element :p_8, 'p', text: 'GOV.UK has more information on legal aid and domestic abuse.'
    element :link_3, 'a', text: ' legal aid and domestic abuse.'
    element :p_9, 'p', text: 'Find out more about domestic abuse and child abuse.'
    element :link_4, 'a', text: 'domestic abuse'
    element :link_5, 'a', text: 'child abuse.'
    element :legend, 'span', text: 'Going to court'
    element :label, 'label', text: 'I understand what’s involved if I decide to go to court'

    element :continue_button, 'button', text: 'Continue'
  end
end
