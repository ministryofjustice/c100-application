require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Children
        class AdditionalDetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/children/additional_details'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Further information'
            element :legend_1, 'span', text: 'Are any of the children known to social services?'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'
            element :not_known, 'label', text: 'Don\'t know'
            element :legend_2, 'span', text: 'Are any of the children the subject of a child protection plan?'
            element :hint, 'div', text: 'A child protection plan is prepared by a local authority where a child is thought to be at risk of significant harm. It sets out steps to be taken to protect the child and support the family.'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
