require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Opening
        class StartOrContinuePage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/opening/start_or_continue'

          section :content, '#main-content' do
            element :header_1, 'h1', text: 'Start or continue an application'
            element :start_new, 'label', text: 'Start a new application'
            element :continue, 'label', text: 'Sign in to continue an application'
            element :span_1, 'span', text: 'If you do not know where the children live, or they live at different addresses'
            element :details_text_1, 'p', text: 'If you do not know where the children live, enter your own postcode.'
            element :details_text_2, 'p', text: 'If the children live at different addresses, enter the postcode of the eldest child who is part of the application.'
            element :header_2, 'h3', text: 'If you are a legal representative'
            element :subheader, 'p', text: 'Confirm this before you proceed'
            element :confirmation, 'label', text: 'I am a legal representative who is acting for the applicant'
            element :span_2, 'span', text: 'Contact us for help'
            element :header_3, 'h3', text: 'Get in touch'
            element :link_1, 'a', text: 'C100applications@justice.gov.uk'
            element :link_2, 'a', text: 'contact the relevant court'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
