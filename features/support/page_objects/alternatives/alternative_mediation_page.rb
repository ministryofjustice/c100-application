class AlternativeMediationPage < YesNoPage
  set_url '/steps/alternatives/mediation'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Professional mediation'
  end
end