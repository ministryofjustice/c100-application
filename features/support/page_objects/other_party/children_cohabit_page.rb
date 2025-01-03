require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module OtherParty
        class ChildrenCohabitPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/other_party/children_cohabit_other'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Do any of the children live with'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
