class SafetyConcernDomesticPage < YesNoPage
  set_url '/steps/safety_questions/domestic_abuse'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have you suffered or are you at risk of suffering domestic abuse?'
  end
end