require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Applicant
        class NamesPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/applicant/names'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Enter your name'
            element :inset_text_1, 'p', text: 'You and anyone else making this application are known as the applicants.'
            element :inset_text_2, 'p', text: 'The other people who will receive this application are known as the respondents. We will ask for their details later.'
            element :legend, 'span', text: 'Enter a new name'
            element :label_1, 'label', text: 'First name(s)'
            element :first_name, '#steps-applicant-names-split-form-new-first-name-field'
            element :first_name_error, '#steps-applicant-names-split-form-new-first-name-field-error'
            element :hint, 'div', text: 'Include all middle names here'
            element :label_2, 'label', text: 'Last name(s)'
            element :last_name, '#steps-applicant-names-split-form-new-last-name-field'
            element :last_name_error, '#steps-applicant-names-split-form-new-last-name-field-error'
            element :error_link_1, 'a', text: 'Enter the first name'
            element :error_link_2, 'a', text: 'Enter the last name'
            element :error_link_3, 'a', text: 'Name must not contain special characters'

            element :add_button, 'button', text: 'Add another applicant'
            element :continue_button, 'button', text: 'Continue'
          end

          def error_title
            'Error: Applicant names - Apply to court about child arrangements - GOV.UK'
          end
        end
      end
    end
  end
end
