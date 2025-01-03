require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Application
        class ReceiptEmailCheckPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/application/receipt_email_check'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Is this email address correct?'
            element :p, 'p', text: 'You’ll receive a confirmation email to this address. Please make sure it’s correct and that you can access the email account.'

            element :continue_button, 'button', text: 'Yes, continue'
            element :link, 'a', text: 'No, change it'
          end
        end
      end
    end
  end
end
