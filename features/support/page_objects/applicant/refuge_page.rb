require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Applicant
        class RefugePage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/applicant/refuge/{id}'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Are you currently resident in a refuge?'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'
            element :error_link, 'a', text: 'You must keep your current address private from the other people in this application if you are currently resident in a refuge. Select current address on the previous page if you are currently resident in a refuge'
            element :continue_button, 'button', text: 'Continue'
          end

          def submit_yes
            content.yes.click
            content.continue_button.click
          end

          def submit_no
            content.no.click
            content.continue_button.click
          end

          def error_title
            'Error: Are you currently resident in a refuge? - Apply to court about child arrangements - GOV.UK'
          end
        end
      end
    end
  end
end
