class AbductionRiskDetailsPage < BasePage
  set_url '/steps/abduction/risk_details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Why do you think the children may be abducted or kept outside the UK without your consent?'
    element :risk_details, '#steps-abduction-risk-details-form-risk-details-field'
    element :current_location, '#steps-abduction-risk-details-form-current-location-field'
    element :continue_button, "button", text: "Continue"
  end

  def submit_risk_details(details, location)
    content.risk_details.set details
    content.current_location.set location
    content.continue_button.click
  end
end