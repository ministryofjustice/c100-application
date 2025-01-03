require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Abduction
        class PreviousAttemptDetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/abduction/previous_attempt_details'

          section :content, '#main-content' do
            element :caption, 'span', text: 'Safety concerns'
            element :header, 'h1', text: 'Provide details of the previous abductions'
            element :label, 'label', text: 'Give a short description of the previous abductions'
            element :hint_1, 'div', text: 'Include any previous attempts or threats to abduct them'
            element :legend, 'span', text: 'Were the police, private investigators or any other organisation involved?'
            element :hint_2, 'div', text: 'Including in the UK or abroad'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
