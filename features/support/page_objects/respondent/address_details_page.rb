class AddressDetailsPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/respondent/address_details'

  section :content, '#content' do
    element :header, 'h1', text: /Address details of .*?/
    element :inset_text, 'div', text: 'Include as much detail as you can. If there’s information missing, your application may take longer to process.'
    element :address, 'label', text: 'Building and street'
    element :hint_1, 'div', text: 'Court documents will be sent here'
    element :town_or_city, 'label', text: 'Town or city'
    element :country, 'label', text: 'Country'
    element :postcode, 'label', text: 'Postcode'
    element :hint_2, 'div', text: 'Enter postcode if known or UK address'
    element :not_known_1, 'label', text: 'I don’t know where they currently live'
    element :legend, 'span', text: 'Have they lived at this address for more than 5 years?'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
    element :not_known_2, 'label', text: 'Don\'t know'
    element :previous_addresses, 'label', text: 'Please provide details of all previous addresses for the last 5 years below, including the dates and starting with the most recent'
    element :hint_3, 'div', text: 'Leave blank if you don’t know'

    element :continue_button, 'button', text: 'Continue'
  end
end
