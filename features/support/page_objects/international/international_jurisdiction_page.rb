class InternationalJurisdictionPage < YesNoPage
  set_url '/steps/international/jurisdiction'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Do you think another person in this application may be able to apply for a similar order in a country outside England or Wales?'
    element :details, 'textarea[name="steps_international_jurisdiction_form[international_jurisdiction_details]"]'
  end

  def submit_yes(details)
    selection_area.answer_yes.click
    content.details.set details
    selection_area.continue_button.click
  end
end