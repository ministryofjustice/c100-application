class AttendingCourtIntermediaryPage < YesNoPage
  set_url '/steps/attending_court/intermediary'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Does anyone in this application need an intermediary to help them in court?'
    element :intermediary_details, 'textarea[name="steps_attending_court_intermediary_form[intermediary_help_details]"]'
  end

  def submit_yes(intermediary_details)
    selection_area.answer_yes.click
    content.intermediary_details.set intermediary_details
    selection_area.continue_button.click
  end
end