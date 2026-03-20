class AddressLookupPage < BasePage
  set_url '/steps/address/lookup'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Address of'
    element :postcode_field, "input[name='steps_address_lookup_form[postcode]']"
    element :outside_uk_link, "a", text: "I live outside the UK"
    element :continue_button, "button", text: "Continue"
  end

  def submit_postcode(postcode)
    content.postcode_field.set postcode
    content.continue_button.click
  end

  def click_outside_uk
    content.outside_uk_link.click
  end

  def continue_without_postcode
    content.continue_button.click
  end
end