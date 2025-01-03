require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Application
        class CourtProceedingsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/application/court_proceedings'

          section :content, '#main-content' do
            element :caption, 'span', text: 'Previous proceedings'
            element :header, 'h1', text: 'Details of previous court case'
            element :label_1, 'label', text: 'Names of children involved'
            element :label_2, 'label', text: 'Name of court'
            element :label_3, 'label', text: 'Case number'
            element :hint_1, 'div', text: 'Leave blank if you don’t know'
            element :inset_text, 'div', text: 'If you have your case number it will help us process your application more quickly.'
            element :label_4, 'label', text: 'Date/year'
            element :hint_2, 'div', text: 'Add approximate date if unsure'
            element :label_5, 'label', text: 'Name and office of Cafcass/Cafcass Cymru officer'
            element :label_6, 'label', text: 'Type of proceedings'
            element :hint_3, 'div', text: 'For example, an Emergency protection order, Supervision order, Care order or any orders related to child abduction'
            element :label_7, 'label', text: 'Add details of any other previous family case'
            element :hint_4, 'div', text: 'Try and include as many details as possible, for example case number, date and name of court'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
