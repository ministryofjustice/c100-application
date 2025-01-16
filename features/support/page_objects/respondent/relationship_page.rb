require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Respondent
        class RelationshipPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/respondent/relationship/'

          section :content, '#main-content' do
            element :header, 'h1', text: /What is .*?'s relationship to .*?\?/
            element :mother, 'label', text: 'Mother'
            element :father, 'label', text: 'Father'
            element :guardian, 'label', text: 'Guardian'
            element :special_guardian, 'label', text: 'Special guardian'
            element :grandparent, 'label', text: 'Grandparent'
            element :other, 'label', text: 'Other'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
