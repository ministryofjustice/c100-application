require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module SafetyQuestions
        class RiskOfAbductionPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/safety_questions/risk_of_abduction'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Safety concerns Are the children at risk of being abducted?'
            element :legend, 'span', text: 'Safety concerns'
            element :description, 'p', text: 'For example, there is a chance they may be taken or kept outside the UK without your consent.'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
