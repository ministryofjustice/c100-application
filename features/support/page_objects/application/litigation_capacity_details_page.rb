require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Application
        class LitigationCapacityDetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/application/litigation_capacity_details'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Factors affecting ability to participate'
            element :label_1, 'label', text: 'Details of any adult in this application who lacks the mental capacity to conduct these court proceedings (if applicable)'
            element :hint_1, 'div', text: 'This means they are unable to make a decision for themselves because of an impairment or disturbance of their mind or brain (within the meaning of the Mental Capacity Act 2005)'
            element :label_2, 'label', text: 'Details of anything else that could affect any adult in this application taking part in these court proceedings (if applicable)'
            element :hint_2, 'div', text: 'For example, a learning disability or other mental or physical health problem'
            element :label_3, 'label', text: 'Details of anyone in this application who has been referred to or assessed by an Adult Learning Disability team or any adult health service and what the outcome was (if you know)'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
