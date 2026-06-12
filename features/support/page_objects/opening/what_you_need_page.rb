class WhatYouNeedPage < BasePage
  set_url '/steps/opening/start'

  section :content, '#main-content' do
    element :header, 'h1', text: 'What you’ll need to complete your application'
    element :continue, 'a', text: 'Continue'
    element :childrens_postcode_field, "input[name='steps_opening_start_or_continue_form[children_postcode]']", visible: false
    element :continue_button, "button", text: "Continue"
  end

  def continue_to_next_step
    content.continue.click
  end
end