require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Applicant
        class PrivacyPreferencesPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/applicant/privacy_preferences/{id}'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Keeping your contact details private'
            element :p_1, 'p', text: 'The answers you give in your response will be shared with other people named in this application (the respondents). This will include your contact details.'
            element :p_2, 'p', text: 'For example, if you believe the other people in the case pose a risk to you or your children, you can ask the court to keep your contact details private.'
            element :p_3, 'p', text: 'Please note: you will need to make sure that any form or document, either completed by you now, or at a later date, for use in court does not contain the information you wish to keep private. This includes documents received from other people e.g. medical reports or financial statements etc.'
            element :p_4, 'p', text: 'The court staff are not able to check the documents you submit to the court for any unintentional disclosure of your contact details.'
            element :legend_1, 'span', text: 'Do you want to keep your contact details private from the other people named in the application (the respondents)?'
            element :yes, 'label', text: 'Yes'
            element :legend_2, 'span', text: 'Which contact details do you want to keep private from the other people in this application?'
            element :label_1, 'label', text: 'Current address'
            element :label_2, 'label', text: 'Email address'
            element :label_3, 'label', text: 'Mobile phone number'
            element :label_4, 'label', text: 'Home phone number'
            element :no, 'label', text: 'No'
            element :error_link, 'a', text: 'Select an option'

            element :continue_button, 'button', text: 'Continue'
          end

          def error_title
            'Error: Contact details confidentiality - Apply to court about child arrangements - GOV.UK'
          end
        end
      end
    end
  end
end
