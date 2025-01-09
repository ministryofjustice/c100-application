require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Address
        class LookupPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/address/lookup/{id}'

          section :content, '#main-content' do
            element :header, 'h1', text: /Address of .*?/
            element :label, 'label', text: 'Current postcode'
            element :link, 'a', text: 'I live outside the UK'
            element :error_link, 'a', text: 'Enter the postcode'

            element :continue_button, 'button', text: 'Continue'
          end

          def error_title
            'Error: Address lookup - Apply to court about child arrangements - GOV.UK'
          end
        end
      end
    end
  end
end
