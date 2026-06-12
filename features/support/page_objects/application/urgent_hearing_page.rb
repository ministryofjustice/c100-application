class UrgentHearingPage < YesNoPage
  set_url '/steps/application/urgent_hearing'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Do you need an urgent hearing?'
  end
end