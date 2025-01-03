class OrdersPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/petition/orders'

  section :content, '#main-content' do
    element :header, 'h1', text: 'What are you asking the court to decide about the children involved?'
    element :legend, 'div', text: 'Select all that apply'
    element :radio_1, 'label', text: 'Decide who they live with and when'
    element :radio_2, 'label', text: 'Decide how much time they spend with each person'
    element :radio_3, 'label', text: 'Stop the other person doing something'
    element :hint_1, 'div', text: 'For example, moving abroad or abducting the children'
    element :radio_4, 'label', text: 'Resolve a specific issue'
    element :hint_2, 'div', text: 'For example, what school they’ll go to'

    element :continue_button, 'button', text: 'Continue'
  end
end
