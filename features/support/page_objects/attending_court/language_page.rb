require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module AttendingCourt
        class LanguagePage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/attending_court/language'

          section :content, '#main-content' do
            element :caption, 'span', text: 'Attending court'
            element :header, 'h1', text: 'Does anyone in this application have special language requirements?'
            element :hint, 'div', text: 'One of the people named in this application needs:'
            element :label_1, 'label', text: 'An interpreter'
            element :label_2, 'label', text: 'A sign language interpreter'
            element :label_3, 'label', text: 'To speak Welsh at a court hearing, or read court documents in Welsh'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
