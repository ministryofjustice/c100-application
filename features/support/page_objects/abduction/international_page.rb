require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Abduction
        class InternationalPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/abduction/international'

          section :content, '#main-content' do
            element :caption, 'span', text: 'Safety concerns'
            element :header, 'h1', text: 'Have the police been notified?'
            element :inset_text, 'div', text: 'If you think the children are at risk of being abducted abroad you should contact the police immediately.'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
