class SafetyConcernAbductionPage < YesNoPage
  set_url '/steps/safety_questions/risk_of_abduction'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Are the children at risk of being abducted?'
  end
end