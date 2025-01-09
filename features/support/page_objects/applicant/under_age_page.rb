require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Applicant
        class UnderAgePage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/applicant/under_age/{id}'

          section :content, '#main-content' do
            element :header, 'h1', text: 'As the applicant is under 18'
            element :subheader, 'p', text: 'You’ll need to have someone over 18 to represent you in court hearings and make decisions on your behalf. They will be known as your ‘litigation friend’.'
            element :link_1, 'a', text: 'litigation friend'
            element :p, 'p', text: 'You need to send documents to: Milton Keynes County Court and Family Court. Visit Court and tribunal finder for contact details.'
            element :link_2, 'a', text: 'Court and tribunal finder'
            element :label, 'label', text: 'I understand I need to be represented by a litigation friend, and that my application won’t be processed until the court receives a certificate of suitability or copy of the court order appointing a litigation friend.'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
