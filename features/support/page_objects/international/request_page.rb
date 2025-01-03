require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module International
        class RequestPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/international/request'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Has a request for information or other assistance involving the children been made to or by another country?'
            element :subheader, 'p', text: 'This may be due to child protection concerns, needing to enforce an order abroad, to return a child to England or Wales or to assist with a request from a court in other family proceedings.'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
