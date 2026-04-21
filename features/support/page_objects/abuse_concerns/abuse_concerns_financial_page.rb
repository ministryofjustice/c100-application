class AbuseConcernsFinancialPage < YesNoPage
  set_url '/steps/abuse_concerns/question/children/financial'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have the children ever been financially abused by the respondent?'
  end
end