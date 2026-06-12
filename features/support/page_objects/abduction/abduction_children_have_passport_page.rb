class AbductionChildrenHavePassportPage < YesNoPage
  set_url '/steps/abduction/children_have_passport'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Do any of the children have a passport?'
  end
end