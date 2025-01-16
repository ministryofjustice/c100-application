require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Children
        class SpecialGuardianshipOrderPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/children/special_guardianship_order/'

          section :content, '#main-content' do
            element :header, 'h1', text: /Is there a Special Guardianship Order in force in relation to .*?'?/
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
