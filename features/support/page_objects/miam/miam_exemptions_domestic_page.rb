class MiamExemptionsDomesticPage < BasePage
  set_url '/steps/miam_exemptions/domestic'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Providing evidence of domestic abuse concerns'
    element :domestic_none, 'input[name="steps_miam_exemptions_domestic_form[domestic][]"][value="misc_domestic_none"]', visible: false
    element :continue_button, "button", text: "Continue"
  end

  def submit_none_of_these
    content.domestic_none.click
    content.continue_button.click
  end
end