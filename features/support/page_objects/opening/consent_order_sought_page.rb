require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Opening
        class ConsentOrderSoughtPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/opening/consent_order_sought'

          section :content, '#main-content' do
            element :header, 'h1', text: 'You do not have to attend a MIAM'
            element :subheader, 'p', text: ' As you’re applying for a consent order, you do not have to attend a Mediation Information and Assessment Meeting (MIAM).'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
