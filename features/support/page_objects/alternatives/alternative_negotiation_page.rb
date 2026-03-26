class AlternativeNegotiationPage < YesNoPage
  set_url '/steps/alternatives/negotiation_tools'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Negotiation tools and services'
  end
end