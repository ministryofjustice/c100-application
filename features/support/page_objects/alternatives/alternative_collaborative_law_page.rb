class AlternativeCollaborativeLawPage < YesNoPage
  set_url '/steps/alternatives/collaborative_law'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Collaborative law'
  end
end