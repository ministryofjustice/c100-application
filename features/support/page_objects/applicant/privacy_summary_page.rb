require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Applicant
        class PrivacySummaryPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/applicant/privacy_summary'

          section :content, '#main-content' do
            element :header_private, 'h1', text: 'The court will keep your contact details private'
            element :header, 'h1', text: 'The court will not keep your contact details private'
            element :p, 'p', text: 'You have told us that either the other people named in this application do not know any of your contact details, or you do not want to keep your contact details private from the other people named in this application (the respondents)'
            element :p_private, 'p', text: 'You have told us you want to keep these contact details private'

            element :continue_link, 'a', text: 'Continue'
          end
        end
      end
    end
  end
end
