require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Solicitor
        class AddressDetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/solicitor/address_details'

          section :content, '#content' do
            element :header, 'h1', text: 'Address details of'
            element :address_1, 'label', text: 'Building and street'
            element :address_2, 'label', text: 'Building and street line 2'
            element :address_3, 'label', text: 'Building and street line 3'
            element :town_or_city, 'label', text: 'Town or city'
            element :country, 'label', text: 'Country'
            element :postcode, 'label', text: 'Postcode'
            element :postcode_hint, '.govuk-hint', text: 'Enter postcode if known or UK address'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
