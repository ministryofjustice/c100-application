class SafetyConcernSubstancePage < YesNoPage
  set_url '/steps/safety_questions/substance_abuse'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Do you have any concerns about drug, alcohol or substance abuse?'
    element :substance_abuse_details, 'textarea[name="steps_safety_questions_substance_abuse_form[substance_abuse_details]"]'
  end

  def submit_yes(details)
    selection_area.answer_yes.click
    content.substance_abuse_details.set(details)
    selection_area.continue_button.click
  end
end