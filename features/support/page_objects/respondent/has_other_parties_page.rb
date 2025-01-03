require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Respondent
        class HasOtherPartiesPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/respondent/has_other_parties'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Is there anyone else who should know about your application?'
            element :supplemental, 'p', text: 'For example, you should tell everyone who:'
            element :li_1, 'li', text: 'cares for the children (but is not their parent), including social services if the children are in local authority accommodation (such as foster care or a children\'s home)'
            element :li_2, 'li', text: 'is currently involved in another court case or named in a current court order that concerns the children and is relevant to this application'
            element :li_3, 'li', text: 'the child has lived with for at least 3 years prior to this application'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
