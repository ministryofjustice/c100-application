require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Respondent
        class ContactDetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/respondent/contact_details'

          section :content, '#main-content' do
            element :header, 'h1', text: /Contact details of .*?/
            element :inset_text, 'p', text: 'Include as much detail as you can. If there’s information missing, your application may take longer to process.'
            element :email, 'label', text: 'Email address'
            element :not_known_1, 'label', text: 'I don\'t know their email'
            element :home_phone, 'label', text: 'Home phone'
            element :not_known_2, 'label', text: 'I don\'t know their home phone number'
            element :mobile_phone, 'label', text: 'Mobile phone'
            element :not_known_3, 'label', text: 'I don\'t know their mobile phone number'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
