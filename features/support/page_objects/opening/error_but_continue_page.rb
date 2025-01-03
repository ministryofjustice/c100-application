require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Opening
        class ErrorButContinuePage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/opening/error_but_continue'

          section :content, '#main-content' do
            element :header_1, 'h1', text: 'Something went wrong'
            element :subheader, 'p', text: 'Although the postcode you entered looks like it’s in the right format, our checker didn’t recognise it. This can happen sometimes if it’s a very new or old postcode.'
            element :header_2, 'h2', text: 'What to do now'
            element :p, 'p', text: 'You can go back and try again, or download the C100 paper form to print and fill in offline. You can then submit the completed form by post or in person at the court.'

            element :download_button, 'button', text: 'Download the form (PDF)'
            element :try_again_button, 'button', text: 'Go back and try again'
          end
        end
      end
    end
  end
end
