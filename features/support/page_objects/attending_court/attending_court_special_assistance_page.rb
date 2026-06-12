class AttendingCourtSpecialAssistancePage < BasePage
 set_url '/steps/attending_court/special_assistance'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Does anyone in this application need assistance or special facilities when attending court?'
    element :hearing_loop, 'input[id="steps-attending-court-special-assistance-form-special-assistance-hearing-loop-field"]', visible: false
    element :braille_documents, 'input[id="steps-attending-court-special-assistance-form-special-assistance-braille-documents-field"]', visible: false
    element :advance_court_viewing, 'input[id="steps-attending-court-special-assistance-form-special-assistance-advance-court-viewing-field"]', visible: false
    element :other_assistance, 'input[id="steps-attending-court-special-assistance-form-special-assistance-other-assistance-field"]', visible: false
    element :special_assistance_details, 'textarea[name="steps_attending_court_special_assistance_form[special_assistance_details]"]'
    element :continue_button, "button", text: "Continue"
  end

  def submit_special_assistance(hearing_loop: false, braille_documents: false, advance_court_viewing: false, other_assistance: false, special_assistance_details: nil)
    content.hearing_loop.set(hearing_loop) if hearing_loop
    content.braille_documents.set(braille_documents) if braille_documents
    content.advance_court_viewing.set(advance_court_viewing) if advance_court_viewing
    content.other_assistance.set(other_assistance) if other_assistance
    content.special_assistance_details.set(special_assistance_details) if special_assistance_details
    
    content.continue_button.click
  end

  def continue_without_filling
    content.continue_button.click
  end
end