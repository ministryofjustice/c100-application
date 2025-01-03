require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module MiamExemptions
        class ProtectionPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/miam_exemptions/protection'

          section :content, '#main-content' do
            element :caption, 'span', text: 'MIAM exemptions'
            element :header, 'h1', text: 'Confirming child protection concerns'
            element :legend, 'span', text: 'Do you confirm any of the following child protection concerns?'
            element :hint, 'div', text: 'Select all that apply or ‘None of these’'
            element :label_1, 'label', text: 'A local authority is carrying out enquiries under Section 47 of the Children Act 1989 or assessment about any of the children in this application, or other child in the household.'
            element :label_2, 'label', text: 'Any of the children in this application, or other child in the household, is the subject of a child protection plan.'
            element :radio_divider, 'div', text: 'or'
            element :label_3, 'label', text: 'None of these'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
