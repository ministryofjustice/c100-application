require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Children
        class ResidencePage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/children/residence'

          section :content, '#main-content' do
            element :header, 'h1', text: /Who does .*? currently live with?/
            element :hint, 'div', text: 'Select all that apply'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
