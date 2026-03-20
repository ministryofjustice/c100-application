class MiamExemptionsProtectionPage < YesNoPage
  set_url '/steps/miam_exemptions/protection'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Confirming child protection concerns'
    element :protection_none, 'input[name="steps_miam_exemptions_protection_form[protection][]"][value="misc_protection_none"]', visible: false
    element :continue_button, "button", text: "Continue"
  end

  def submit_none_of_these
    content.protection_none.click
    content.continue_button.click
  end
end