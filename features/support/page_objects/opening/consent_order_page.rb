class ConsentOrderPage < BasePage
  set_url '/steps/opening/consent_order'

  section :content, '#main-content' do
    element :header, 'h1', text: 'What kind of application do you want to make?'
    element :consent_order_yes, "input#steps-opening-consent-order-form-consent-order-yes-field", visible: false
    element :consent_order_no, "input#steps-opening-consent-order-form-consent-order-no-field", visible: false
    element :continue_button, "button", text: "Continue"
  end

  def continue_to_next_step
    content.continue.click
  end

  def submit_existing_consent_order
    content.consent_order_yes.click
    content.continue_button.click
  end

  def submit_without_consent_order
    content.consent_order_no.click
    content.continue_button.click
  end
end