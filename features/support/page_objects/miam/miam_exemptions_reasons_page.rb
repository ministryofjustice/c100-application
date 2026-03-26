class MiamExemptionsReasonsPage < YesNoPage
  set_url '/steps/miam_exemptions/exemption_reasons'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Evidence of MIAM exemption'
    element :misc_none, 'input[name="steps_miam_exemptions_misc_form[misc][]"][value="misc_none"]', visible: false
    element :exemption_reasons, 'textarea[name="steps_miam_exemptions_exemption_reasons_form[exemption_reasons]"]'
    element :continue_button, "button", text: "Continue"
  end

  def submit_no_exemption_reasons(reasons)
    selection_area.answer_no.click
    content.exemption_reasons.set reasons
    content.continue_button.click
  end

  def submit_yes
    selection_area.answer_yes.click
    content.continue_button.click
  end
end