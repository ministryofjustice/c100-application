require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module MiamExemptions
        class ExemptionDetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/miam_exemptions/exemption_details'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Provide details of exemptions from attending a MIAM'
            element :p, 'p', text: 'Enter the following details where applicable:'
            element :li_1, 'li', text: 'Why the prospective applicant is not able to attend a MIAM online or by video-link and an explanation of why this is the case'
            element :li_2, 'li', text: 'The names, postal addresses and telephone numbers or e-mail addresses for authorised family mediators, and the dates of contact'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
