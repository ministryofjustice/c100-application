require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Opening
        class WarningPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/opening/warning'

          section :content, '#main-content' do
            element :header, 'h1', text: 'It looks like you already have an application in progress'
            element :subheader, 'p', text: 'You can resume your current application so you don\'t lose your progress, or you can start a new application. '

            element :resume_button, 'button', text: 'Resume application'
            element :new_button, 'button', text: 'Start a new application'
          end
        end
      end
    end
  end
end
