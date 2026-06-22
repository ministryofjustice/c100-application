class UploadConsentOrderPage < UploadPage
  set_url '/'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Upload the draft of your consent order'
    element :consent_order_yes, "input#steps-opening-consent-order-form-consent-order-yes-field", visible: false
    element :consent_order_no, "input#steps-opening-consent-order-form-consent-order-no-field", visible: false
  end
end
