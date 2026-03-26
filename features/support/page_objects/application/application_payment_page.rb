class ApplicationPaymentPage < BasePage
  set_url '/steps/application/payment'

  section :content, '#main-content' do
    element :header, 'h1', text: 'How will you pay the application fee?'
    element :pay_online, 'input[id="steps-application-payment-form-payment-type-online-field"]', visible: false
    element :help_with_fees, 'input[id="steps-application-payment-form-payment-type-help-with-fees-field"]', visible: false
    element :help_with_fees_reference, 'input[id="steps-application-payment-form-hwf-reference-number-field"]'
    element :solicitor, 'input[id="steps-application-payment-form-payment-type-solicitor-field"]', visible: false
    element :solicitor_fee_account_number, 'input[id="steps-application-payment-form-solicitor-account-number-field"]'
    element :continue_button, "button", text: "Continue"
  end

  def pay_online
    content.pay_online.click
    content.continue_button.click
  end

  def pay_by_help_with_fees(reference_number)
    content.help_with_fees.click
    content.help_with_fees_reference.set reference_number
    content.continue_button.click
  end

  def pay_by_solicitor(account_number)
    content.solicitor.click
    content.solicitor_fee_account_number.set account_number
    content.continue_button.click
  end
end