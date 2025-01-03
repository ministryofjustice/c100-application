require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Applicant
        class HasSolicitorPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/applicant/has_solicitor'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Will you be legally represented by a solicitor in these proceedings?'
            element :subheader, 'p', text: 'Any legal representative must be authorised to conduct litigation.'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
