require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module OtherParty
        class NamesPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/other_party/names'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Enter the other person’s name'
            element :legend, 'span', text: 'Enter a new name'
            element :hint, 'div', text: 'Include all middle names here'
            element :first_name, 'label', text: 'First name(s)'
            element :last_name, 'label', text: 'Last name(s)'
            element :another_person, 'button', text: 'Add another person'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
