class SafetyConcernOtherPage < YesNoPage
  set_url '/steps/safety_questions/other_abuse'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Do you have any other safety concerns about you or the children?'
  end
end