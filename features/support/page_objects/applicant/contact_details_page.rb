require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Applicant
        class ContactDetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/applicant/contact_details/{id}'

          section :content, '#main-content' do
            element :header, 'h1', text: /Contact details of .*?/
            element :label_1, 'label', text: 'I can provide an email address'
            element :label_2, 'label', text: 'I cannot provide an email address'
            element :label_3, 'label', text: 'Your home phone'
            element :label_4, 'label', text: 'I can provide a mobile phone number'
            element :label_5, 'label', text: 'I cannot provide a mobile phone number'
            element :legend, 'span', text: 'Can the court leave you a voicemail?'
            element :hint, 'div', text: 'If the court calls you about your application and you cannot answer the phone, we need to know that it’s safe for them to leave a voicemail.'
            element :label_6, 'label', text: 'Yes, the court can leave me a voicemail'
            element :label_7, 'label', text: 'No, the court cannot leave me a voicemail'
            element :error_link_1, 'a', text: 'Select an option'
            element :error_link_2, 'a', text: 'Enter a mobile number or tell us why the court cannot phone you'
            element :error_link_3, 'a', text: 'Enter an email address in the correct format, like name@example.com'
            element :error_link_4, 'a', text: 'Enter a phone number in the correct format, like 07700 900 982'

            element :continue_button, 'button', text: 'Continue'
          end

          def error_title
            'Error: Applicant contact details - Apply to court about child arrangements - GOV.UK'
          end
        end
      end
    end
  end
end
