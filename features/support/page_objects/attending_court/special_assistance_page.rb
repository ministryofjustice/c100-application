require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module AttendingCourt
        class SpecialAssistancePage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/attending_court/special_assistance'

          section :content, '#main-content' do
            element :caption, 'span', text: 'Attending court'
            element :header, 'h1', text: 'Does anyone in this application need assistance or special facilities when attending court?'
            element :hint, 'div', text: 'One of the people named in this application needs:'
            element :label_1, 'label', text: 'A hearing loop'
            element :label_2, 'label', text: 'Documents in Braille'
            element :label_3, 'label', text: 'Advance viewing of the court'
            element :label_4, 'label', text: 'Other assistance or facilities'
            element :label_5, 'label', text: 'You can add more detail if necessary'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
