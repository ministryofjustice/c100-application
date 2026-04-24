class AttendingCourtIntermediaryPage < YesNoPage
  set_url '/steps/attending_court/intermediary'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Does anyone in this application need an intermediary to help them in court?'
  end
end