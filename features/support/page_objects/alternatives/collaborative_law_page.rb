require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Alternatives
        class CollaborativeLawPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/alternatives/collaborative_law'

          section :content, '#main-content' do
            element :caption, 'span', text: 'Alternative ways to reach an agreement'
            element :header, 'h1', text: 'Collaborative law'
            element :p_1, 'p', text: 'Collaborative lawyers work with you and the other parent to resolve your issues out of court. You each hire a lawyer then all meet to negotiate face-to-face.'
            element :p_2, 'p', text: 'The collaborative process involves several steps but is usually quicker and cheaper than going to court.'
            element :p_3, 'p', text: 'Collaborative law is suitable for people who can still communicate with each other but may have complex legal issues to resolve.'
            element :link, 'a', text: 'Find out more about collaborative law'
            element :legend, 'span', text: 'Have you tried collaborative law?'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'
            element :subheader_1, 'h2', text: 'Pros'
            element :li_1, 'li', text: 'everyone is committed to not going to court'
            element :li_2, 'li', text: 'quicker and less stressful than court'
            element :li_3, 'li', text: 'you and the other parent set the agenda'
            element :li_4, 'li', text: 'lawyers are present throughout'
            element :li_5, 'li', text: 'good for the children to see their parents working together'
            element :subheader_2, 'h2', text: 'Cons'
            element :li_6, 'li', text: 'can be an expensive process'
            element :li_7, 'li', text: 'won’t work unless you can trust the other parent and co-operate with them'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
