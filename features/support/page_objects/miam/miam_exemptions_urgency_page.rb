class MiamExemptionsUrgencyPage < BasePage
  set_url '/steps/miam_exemptions/urgency'
  
  section :content, '#main-content' do
    element :header, 'h1', text: 'Confirming why your application is urgent'
    element :urgency_none, 'input[name="steps_miam_exemptions_urgency_form[urgency][]"][value="misc_urgency_none"]', visible: false
    element :continue_button, "button", text: "Continue"
  end

  def submit_none_of_these
    content.urgency_none.click
    content.continue_button.click
  end
end