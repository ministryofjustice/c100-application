require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Applicant
        class PrivacyKnownPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/applicant/privacy_known/{id}'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Keeping your contact details private'
            element :legend, 'span', text: 'Do the other people named in this application (the respondents) know any of your contact details?'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'
            element :not_known, 'label', text: 'I don\'t know'
            element :error_link, 'a', text: 'Select an option'

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

          def submit_not_known
            content.not_known.click
            content.continue_button.click
          end

          def error_title
            'Error: Contact details confidentiality - Apply to court about child arrangements - GOV.UK'
          end
        end
      end
    end
  end
end
