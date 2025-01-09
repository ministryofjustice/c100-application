require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Solicitor
        class PersonalDetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/solicitor/personal_details'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Details of solicitor'
            element :subheader, 'p', text: 'This is the person who’s been instructed to act in these proceedings.'
            element :full_name, 'label', text: 'Full name'
            element :firm_name, 'label', text: 'Name of firm'
            element :reference, 'label', text: 'Solicitor’s reference'
            element :reference_hint, '.govuk-hint', text: 'This is the reference for this case'
            element :error_link_1, 'a', text: 'Enter the full name'
            element :error_link_2, 'a', text: 'Enter the name of the firm'
            element :error_link_3, 'a', text: 'Name must not contain special characters'

            element :continue_button, 'button', text: 'Continue'
          end

          def error_title
            'Error: Details of solicitor - Apply to court about child arrangements - GOV.UK'
          end
        end
      end
    end
  end
end

