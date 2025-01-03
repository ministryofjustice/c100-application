require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Alternatives
        class LawyerNegotiationPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/alternatives/lawyer_negotiation'

          section :content, '#main-content' do
            element :caption, 'span', text: 'Alternative ways to reach an agreement'
            element :header, 'h1', text: 'Lawyer negotiation'
            element :p_1, 'p', text: 'With lawyer negotiation you don’t deal directly with the person. You hire a lawyer to negotiate arrangements for you.'
            element :p_2, 'p', text: 'You can still hire a lawyer to negotiate on your behalf even if the other person chooses not to use one.'
            element :p_3, 'p', text: 'Lawyer negotiation is suitable for people who prefer not to meet because their relationship is still difficult, or because there’s a lack of trust.'
            element :link, 'a', text: 'Find out more about lawyer negotiation'
            element :legend, 'span', text: 'Have you tried lawyer negotiation?'
            element :subheader_1, 'h2', text: 'Pros'
            element :li_1, 'li', text: 'your lawyer supports you throughout'
            element :li_2, 'li', text: 'quicker and less stressful than court'
            element :li_3, 'li', text: 'you don’t deal directly with the other parent'
            element :subheader_2, 'span', text: 'Cons'
            element :li_4, 'li', text: 'can be a more expensive process'
            element :li_5, 'li', text: 'you may feel you’re not in control'
            element :li_6, 'li', text: 'can be seen as a confrontational approach'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
