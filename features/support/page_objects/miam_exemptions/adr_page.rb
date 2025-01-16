require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module MiamExemptions
        class AdrPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/miam_exemptions/adr'

          section :content, '#main-content' do
            element :caption, 'span', text: 'MIAM exemptions'
            element :header, 'h1', text: 'You’ve already been to a MIAM or are taking part in another form of non-court dispute resolution'
            element :legend, 'span', text: 'Do you confirm any of the following reasons for not attending a MIAM?'
            element :label_1, 'label', text: 'In the 4 months prior to making the application, the person attended a MIAM or a non-court dispute resolution process relating to the same or substantially the same dispute; and where the applicant attended a non-court dispute resolution process, there is evidence of that attendance in the form of written confirmation from the dispute resolution provider.'
            element :hint_1, 'div', text: 'This evidence should be submitted alongside your application to court, and must include the signature of the provider.'
            element :label_2, 'label', text: 'The application would be made in existing proceedings which are continuing and the prospective applicant attended a MIAM before initiating those proceedings. The MIAM provider must sign a document proving this attendance, to be submitted alongside your application to court.'
            element :radio_divider, 'div', text: 'or'
            element :label_3, 'div', text: 'None of these'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
