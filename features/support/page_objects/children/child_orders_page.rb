class ChildOrdersPage < BasePage
  set_url_matcher %r{/steps/children/orders/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'Which of the decisions you’re asking the court to resolve relate to'
    elements :orders, ".govuk-checkboxes__label"
    element :continue_button, "button", text: "Continue"
  end

  def submit_child_orders(orders_list)
    orders_list.each do |order|
      content.orders.find { |option| option.value == order }.click
    end
    content.continue_button.click
  end

  def submit_all_child_orders
    content.orders.each(&:click)
    content.continue_button.click
  end
end