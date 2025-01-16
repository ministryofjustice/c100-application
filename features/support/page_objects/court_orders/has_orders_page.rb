require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module CourtOrders
        class HasOrdersPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/court_orders/has_orders'

          section :content, '#main-content' do
            element :caption, 'span', text: 'Safety concerns'
            element :header, 'h1', text: 'Have you had or do you currently have any court orders made for your protection?'
            element :hint, 'div', text: 'For example, a restraining order, non-molestation order, occupation order or forced marriage protection order.'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
