require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Applicant
        class PrivacyKnownPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/applicant/privacy_known'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Keeping your contact details private'
            element :legend, 'span', text: 'Do the other people named in this application (the respondents) know any of your contact details?'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'
            element :not_known, 'label', text: 'I don\'t know'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
