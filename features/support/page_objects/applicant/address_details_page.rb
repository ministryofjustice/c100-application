require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Applicant
        class AddressDetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/applicant/address_details/{id}'

          section :content, '#main-content' do
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
            element :error_link_1, 'a', text: 'Enter the first line of the address'
            element :error_link_2, 'a', text: 'Enter the town or city'
            element :error_link_3, 'a', text: 'Enter the country'
            element :error_link_4, 'a', text: 'Select yes if you’ve lived at the address for more than 5 years'

            element :continue_button, 'button', text: 'Continue'
          end

          def error_title
            'Error: Applicant address details - Apply to court about child arrangements - GOV.UK'
          end
        end
      end
    end
  end
end
