class PreviousProceedingsPage < YesNoPage
  set_url '/steps/application/previous_proceedings'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have any of the children in this application been involved in other family court proceedings?'
  end
end