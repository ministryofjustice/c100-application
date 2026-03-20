class MiamExemptionsAdrPage < BasePage
  set_url '/steps/miam_exemptions/adr'

  section :content, '#main-content' do
    element :header, 'h1', text: 'You’ve already been to a MIAM or are taking part in another form of non-court dispute resolution'
    element :adr_none, 'input[name="steps_miam_exemptions_adr_form[adr][]"][value="misc_adr_none"]', visible: false
    element :continue_button, "button", text: "Continue"
  end

  def submit_none_of_these
    content.adr_none.click
    content.continue_button.click
  end
end