require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Alternatives
        class StartPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/alternatives/start'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Alternative ways to reach an agreement'
            element :p_1, 'p', text: 'As you have no safety concerns you should see if there’s a more suitable way to agree child arrangements than going to court.'
            element :p_2, 'p', text: 'Evidence shows it’s usually better for the children if you can reach an agreement another way.'
            element :p_3, 'p', text: 'By reaching an agreement out of court you may be able to:'
            element :li_1, 'li', text: 'make the situation less stressful for the children'
            element :li_2, 'li', text: 'help the children continue family relationships'
            element :li_3, 'li', text: 'save time and money'
            element :li_4, 'li', text: 'reduce conflict with the other person'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
