require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Application
        class DetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/application/details'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Why are you making this application?'
            element :p, 'p', text: 'You should include details of any of the following (if they apply):'
            element :li_1, 'li', text: 'your reasons for bringing this application to court'
            element :li_2, 'li', text: 'what you want the court to decide (what outcome you want)'
            element :li_3, 'li', text: 'why the other person disagrees'
            element :li_4, 'li', text: 'any previous parenting plans or agreements (formal or informal), and why they broke down'
            element :link, 'a', text: 'parenting plans'
            element :label, 'label', text: 'Provide details'
            element :hint, 'div', text: 'You do not have to give a full statement although you may be asked to provide one later.'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
