require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Opening
        class ChildProtectionInfoPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/opening/child_protection_info'

          section :content, '#main-content' do
            element :header, 'h1', text: 'You do not have to attend a MIAM'
            element :subheader, 'p', text: 'As there are or have been safety concerns about the children, you do not have to attend a Mediation Information and Assessment Meeting (MIAM).'
            element :p, 'p', text: 'We will ask you about these concerns later in the application.'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
