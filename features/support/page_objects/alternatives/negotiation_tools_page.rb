require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Alternatives
        class NegotiationToolsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/alternatives/negotiation_tools'

          section :content, '#main-content' do
            element :caption, 'span', text: 'Alternative ways to reach an agreement'
            element :header, 'h1', text: 'Negotiation tools and services'
            element :p_1, 'p', text: 'If you still communicate with the other person, and there are no concerns about domestic or child abuse, the cheapest and easiest way to make arrangements is to negotiate with each other.'
            element :p_2, 'p', text: 'There are free tools and services such as parenting plans that can help you reach an agreement.'
            element :link_1, 'a', text: 'parenting plans'
            element :link_2, 'a', text: 'Find out more about negotiation tools and services'
            element :legend, 'span', text: 'Have you tried any negotiation tools or services?'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'
            element :subheader_1, 'h2', text: 'Pros'
            element :li_1, 'li', text: 'cheapest and quickest option'
            element :li_2, 'li', text: 'you and the other parent are in control'
            element :li_3, 'li', text: 'helps children continue family relationships'
            element :li_4, 'li', text: 'agreements are flexible'
            element :subheader_2, 'h2', text: 'Cons'
            element :li_5, 'li', text: 'you’ll need a consent order to make agreement legally binding'
            element :li_6, 'li', text: 'process heavily relies on parent co-operation'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
