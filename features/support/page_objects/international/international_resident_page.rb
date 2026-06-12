class InternationalResidentPage < YesNoPage
  set_url '/steps/international/resident'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Do you have any reason to believe that any child, parent or potentially significant adult in the child’s life may be habitually resident in another country abroad or in Scotland or Northern Ireland?'
    element :details, 'textarea[name="steps_international_resident_form[international_resident_details]"]'
  end


  def submit_yes(details)
    selection_area.answer_yes.click
    content.details.set details
    selection_area.continue_button.click
  end
end