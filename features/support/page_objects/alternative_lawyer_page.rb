class AlternativeLawyerPage < YesNoPage
  set_url '/steps/alternatives/lawyer_negotiation'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Lawyer negotiation'
  end
end