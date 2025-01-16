require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Alternatives
        class MediationPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/alternatives/mediation'

          section :content, '#main-content' do
            element :caption, 'span', text: 'Alternative ways to reach an agreement'
            element :header, 'h1', text: 'Professional mediation'
            element :p_1, 'p', text: 'Mediation sessions are run by professionals who help you try to reach an agreement without going to court.'
            element :p_2, 'p', text: 'Mediation isn’t relationship counselling and you don’t have to be in the same room as the other parent.'
            element :p_3, 'p', text: 'Mediation is suitable for people who want to reach an agreement but need help from someone who is independent.'
            element :link_1, 'a', text: 'Find out more about professional mediation'
            element :inset_text_1, 'p', text: 'You could get up to £500 towards family mediation'
            element :inset_text_2, 'a', text: 'This is a new scheme available for a short time only. Find out more about the family mediation voucher scheme.'
            element :link_2, 'a', text: 'family mediation voucher scheme'
            element :legend, 'span', text: 'Have you tried professional mediation?'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'
            element :subheader_1, 'h2', text: 'Pros'
            element :li_1, 'li', text: 'it’s quicker than court in most cases'
            element :li_2, 'li', text: 'can be cheaper than using a lawyer'
            element :li_3, 'li', text: 'less conflict between parents'
            element :li_4, 'li', text: 'helps children continue family relationships'
            element :li_5, 'li', text: 'agreements are flexible'
            element :subheader_2, 'h2', text: 'Cons'
            element :li_6, 'li', text: 'you’ll need a consent order to make agreement legally binding'
            element :li_7, 'li', text: 'process won’t work unless parents can co-operate'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
