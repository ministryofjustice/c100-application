require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Solicitor
        class AddressDetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/solicitor/address_details'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Address details of'
            element :address_1, 'label', text: 'Building and street'
            element :address_2, 'label', text: 'Building and street line 2'
            element :address_3, 'label', text: 'Building and street line 3'
            element :town_or_city, 'label', text: 'Town or city'
            element :country, 'label', text: 'Country'
            element :postcode, 'label', text: 'Postcode'
            element :postcode_hint, '.govuk-hint', text: 'Enter postcode if known or UK address'
            element :error_link_1, 'a', text: 'Enter the first line of the address'
            element :error_link_2, 'a', text: 'Enter the town or city'
            element :error_link_3, 'a', text: 'Enter the country'
            element :error_link_4, 'a', text: 'Enter the postcode'
            element :error_link_5, 'a', text: 'is invalid'

            element :continue_button, 'button', text: 'Continue'
          end

          def error_title
            'Error: Address details of solicitor - Apply to court about child arrangements - GOV.UK'
          end
        end
      end
    end
  end
end
