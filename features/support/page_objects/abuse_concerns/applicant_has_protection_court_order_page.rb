class ApplicantHasProtectionCourtOrderPage < YesNoPage
  set_url '/steps/court_orders/has_orders'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have you had or do you currently have any court orders made for your protection?'
  end
end