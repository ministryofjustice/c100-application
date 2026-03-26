class SafetyConcernAbusePage < YesNoPage
  set_url '/steps/safety_questions/children_abuse'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have the children suffered or are they at risk of suffering domestic or child abuse?'
  end
end