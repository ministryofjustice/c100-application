require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Solicitor
        class ContactDetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/solicitor/contact_details'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Contact details of '
            element :email, 'label', text: 'Email address'
            element :phone_number, 'label', text: 'Phone number'
            element :dx_number, 'label', text: 'DX number'
            element :dx_number_hint, '.govuk-hint', text: 'This is a secure document exchange system used by the legal profession'
            element :error_link_1, 'a', text: 'Enter an email address'
            element :error_link_2, 'a', text: 'Enter a phone number in the correct format, like 07700 900 982'
            element :error_link_3, 'a', text: 'Enter an email address in the correct format, like name@example.com'
            element :error_link_4, 'a', text: 'Enter a valid DX number'

            element :continue_button, 'button', text: 'Continue'
          end

          def error_title
            'Error: Contact details of solicitor - Apply to court about child arrangements - GOV.UK'
          end
        end
      end
    end
  end
end
