require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Abduction
        class PreviousAttemptPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/abduction/previous_attempt'

          section :content, '#main-content' do
            element :caption, 'span', text: 'Safety concerns'
            element :header, 'h1', text: 'Have the children been abducted or kept outside the UK without your consent before?'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
