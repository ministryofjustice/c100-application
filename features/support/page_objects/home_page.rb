class HomePage < BasePage
  set_url '/'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Start or continue an application'
    element :start_application_radio, 'label', text: 'Start a new application'
    element :childrens_postcode_field, "input[name='steps_opening_start_or_continue_form[children_postcode]']", visible: false
  end

  def submit_postcode(postcode)
    content.start_application_radio.click
    content.childrens_postcode_field.set postcode
    click_continue_button
  end
end
