class HomePage < BasePage
  set_url '/'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Start or continue an application'
    element :start_application_radio, 'label', text: 'Start a new application'
    element :childrens_postcode_field, "input[name='steps_opening_start_or_continue_form[children_postcode]']", visible: false
    element :continue_button, "button", text: "Continue"
  end

  def submit_postcode(postcode)
    content.start_application_radio.click
    content.childrens_postcode_field.set postcode
    content.continue_button.click
  end

end
