class OrdersPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/children/orders/'

  section :content, '#main-content' do
    element :header, 'h1', text: /Which of the decisions you’re asking the court to resolve relate to .*? ?/
    element :hint, 'div', text: 'Select all that apply'

    element :continue_button, 'button', text: 'Continue'
  end
end
