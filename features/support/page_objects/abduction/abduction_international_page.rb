class AbductionInternationalPage < YesNoPage
  set_url '/steps/abduction/international'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have the police been notified?'
  end
end