require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module CourtOrders
        class DetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/court_orders/details'

          section :content, '#main-content' do
            element :caption, 'span', text: 'Safety concerns'
            element :header, 'h1', text: 'What orders have been made?'
            element :legend_1, 'span', text: 'Non-molestation order'
            element :legend_2, 'span', text: 'Occupation order'
            element :legend_3, 'span', text: 'Forced marriage protection order'
            element :legend_4, 'span', text: 'Restraining order'
            element :hint, 'div', text: 'Under the Protection from Harassment Act 1997'
            element :legend_5, 'span', text: 'Other injunctive order'
            element :legend_6, 'span', text: 'Undertaking in place of an order'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
