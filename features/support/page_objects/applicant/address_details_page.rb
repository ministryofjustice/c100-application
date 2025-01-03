require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Applicant
        class AddressDetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/applicant/address_details'

          section :content, '#content' do
            element :header, 'h1', text: /Address details of .*?/
            element :address, 'label', text: 'Building and street'
            element :town_or_city, 'label', text: 'Town or city'
            element :country, 'label', text: 'Country'
            element :postcode, 'label', text: 'Postcode'
            element :hint, 'div', text: 'Enter postcode if known or UK address'
            element :legend, 'span', text: 'Have you lived at this address for more than 5 years?'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'
            element :previous_addresses, 'label', text: 'Please provide details of all previous addresses for the last 5 years below, including the dates and starting with the most recent'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
