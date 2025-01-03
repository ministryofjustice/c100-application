class PaymentPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/application/payment'

  section :content, '#main-content' do
    element :header, 'h1', text: 'How will you pay the application fee?'
    element :subheader, 'p', text: 'The court fee is £255. Only the person applying to court (the applicant) or their solicitor needs to pay.'
    element :label, 'label', text: 'Pay with ‘Help with fees’'
    element :hint, 'div', text: 'You may be able to get help paying if you’re on a low income, receive certain benefits or have little or no savings. If you do qualify, you’ll need to provide your reference number'
    element :link, 'a', text: 'get help paying'

    element :continue_button, 'button', text: 'Continue'
  end
end
