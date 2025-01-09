require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Applicant
        class PersonalDetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/applicant/personal_details/{id}'

          section :content, '#main-content' do
            element :header, 'h1', text: /Provide details for .*?/
            element :legend_1, 'span', text: 'Have you changed your name?'
            element :hint_1, 'div', text: 'For example, through marriage or adoption or by deed poll. This includes first name, surname and any middle names'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'
            element :legend_2, 'span', text: 'Sex'
            element :female, 'label', text: 'Female'
            element :male, 'label', text: 'Male'
            element :unspecified, 'label', text: 'Unspecified'
            element :legend_3, 'span', text: 'Your date of birth'
            element :hint_2, 'div', text: 'For example, 31 3 2016'
            element :day, '#steps_applicant_personal_details_form_dob_3i'
            element :month, '#steps_applicant_personal_details_form_dob_2i'
            element :year, '#steps_applicant_personal_details_form_dob_1i'
            element :legend_4, 'span', text: 'Your place of birth'
            element :birthplace, '#steps-applicant-personal-details-form-birthplace-field'
            element :hint_3, 'div', text: 'For example, town or city'
            element :error_link_1, 'a', text: 'Select if you’ve changed your name'
            element :error_link_2, 'a', text: 'Select the sex'
            element :error_link_3, 'a', text: 'Enter the date of birth'
            element :error_link_4, 'a', text: 'Enter your place of birth'
            element :error_link_5, 'a', text: 'Date of birth is not valid'
            element :error_link_6, 'a', text: 'Date of birth must be in the past'

            element :continue_button, 'button', text: 'Continue'
          end

          def error_title
            'Error: Applicant personal details - Apply to court about child arrangements - GOV.UK'
          end
        end
      end
    end
  end
end
