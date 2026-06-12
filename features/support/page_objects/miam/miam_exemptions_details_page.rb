class MiamExemptionsDetailsPage < BasePage
  set_url '/steps/miam_exemptions/exemption_details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Provide details of exemptions from attending a MIAM'
    element :exemption_details, 'textarea[name="steps_miam_exemptions_exemption_details_form[exemption_details]"]'
    element :continue_button, "button", text: "Continue"
  end

  def submit_exemption_details(details)
    content.exemption_details.set details
    content.continue_button.click
  end

  def continue_without_filling
    content.continue_button.click
  end
end