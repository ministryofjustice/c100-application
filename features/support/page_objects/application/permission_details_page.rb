require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Application
        class PermissionDetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/application/permission_details'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Give details to ask for permission to apply'
            element :subheader, 'p', text: 'You need to give details for the court to consider whether to give permission for this application to be made.'
            element :p, 'p', text: 'You could include:'
            element :li_1, 'li', text: 'details of your relationship with the children'
            element :li_2, 'li', text: 'details of any risk of disruption to the child that may be caused by this application'
            element :li_3, 'li', text: 'any plans the Local Authority have made for the children (if this applies)'
            element :li_4, 'li', text: 'the wishes and feelings of the children’s parents (if the child is being looked after by the Local Authority)'
            element :label, 'label', text: 'Provide details to ask for permission'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
