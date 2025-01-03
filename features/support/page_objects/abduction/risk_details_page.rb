class RiskDetailsPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/abduction/risk_details'

  section :content, '#main-content' do
    element :caption, 'span', text: 'Safety concerns'
    element :header, 'h1', text: 'Why do you think the children may be abducted or kept outside the UK without your consent?'
    element :p, 'p', text: 'Briefly explain your concerns, including:'
    element :li_1, 'li', text: 'who might take them'
    element :li_2, 'li', text: 'where they might be taken or kept'
    element :label, 'label', text: 'Where are the children now?'
    element :hint, 'div', text: 'If they\'re outside England or Wales, include what country they\'re in and how long they\'ve been there. You don\'t need to include any addresses.'

    element :continue_button, 'button', text: 'Continue'
  end
end
