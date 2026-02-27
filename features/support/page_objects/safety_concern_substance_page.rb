class SafetyConcernSubstancePage < YesNoPage
  set_url '/steps/safety_questions/substance_abuse'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Do you have any concerns about drug, alcohol or substance abuse?'
  end
end