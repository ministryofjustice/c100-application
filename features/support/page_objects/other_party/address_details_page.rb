require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module OtherParty
        class AddressDetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/other_party/address_details'

          section :content, '#main-content' do
            element :header, 'h1', text: /Address details of .*?/
            element :address, 'label', text: 'Building and street'
            element :hint_1, 'div', text: 'Court documents will be sent here'
            element :town_or_city, 'label', text: 'Town or city'
            element :country, 'label', text: 'Country'
            element :postcode, 'label', text: 'Postcode'
            element :hint_2, 'div', text: 'Enter postcode if known or UK address'
            element :not_known, 'label', text: 'I don’t know where they currently live'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
