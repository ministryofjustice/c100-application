class ConsentOrderPage < BasePage
  set_url '/steps/opening/consent_order'

  section :content, '#main-content' do
    element :header, 'h1', text: 'What kind of application do you want to make?'
    element :consent_order_yes, "input#steps-opening-consent-order-form-consent-order-yes-field", visible: false
    element :consent_order_no, "input#steps-opening-consent-order-form-consent-order-no-field", visible: false
  end

  def submit_existing_consent_order
    content.consent_order_yes.click
    click_continue_button
  end

  def submit_without_consent_order
    content.consent_order_no.click
    click_continue_button
  end
end
