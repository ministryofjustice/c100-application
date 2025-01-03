require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Miam
        class ExemptionClaimPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/miam/exemption_claim'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Do you have a valid reason for not attending a MIAM?'
            element :p, 'p', text: 'If you’re unsure you can check the list of valid reasons.'
            element :link, 'a', text: 'check the list of valid reasons'
            element :inset_text, 'div', text: 'If you\'re claiming that you do not have to attend a MIAM before making this application, you may need to provide evidence in support of this. '
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
