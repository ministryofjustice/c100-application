require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module SafetyQuestions
        class OtherAbusePage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/safety_questions/other_abuse'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Safety concerns Do you have any other safety concerns about you or the children?'
            element :legend, 'span', text: 'Safety concerns'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
