require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Applicant
        class RelationshipPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/applicant/relationship/{id}/child/{id}'

          section :content, '#main-content' do
            element :header, 'h1', text: /What is .*?'s relationship to .*?\?/
            element :mother, 'label', text: 'Mother'
            element :father, 'label', text: 'Father'
            element :guardian, 'label', text: 'Guardian'
            element :special_guardian, 'label', text: 'Special guardian'
            element :grandparent, 'label', text: 'Grandparent'
            element :other, 'label', text: 'Other'
            element :error_link, 'a', text: 'Select the relationship'

            element :continue_button, 'button', text: 'Continue'
          end

          def error_title
            'Error: Applicant relationship - Apply to court about child arrangements - GOV.UK'
          end
        end
      end
    end
  end
end
