class SolicitorAddressDetailsPage < BasePage
  set_url '/steps/solicitor/address_details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Address details of solicitor'
    element :address_line_1_field, "input[name='steps_solicitor_address_details_form[address_line_1]']"
    element :town_field, "input[name='steps_solicitor_address_details_form[town]']"
    element :country_field, "input[name='steps_solicitor_address_details_form[country]']"
    element :postcode_field, "input[name='steps_solicitor_address_details_form[postcode]']"
    element :continue_button, "button", text: "Continue"
  end

  def submit_address_details(address_line_1:, town:, country:, postcode:)
    content.address_line_1_field.set address_line_1
    content.town_field.set town
    content.country_field.set country
    content.postcode_field.set postcode
    content.continue_button.click
  end

  def continue_without_filling
    content.continue_button.click
  end
end