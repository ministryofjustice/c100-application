require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Completion
        class ConfirmationPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/completion/confirmation'

          section :content, '#main-content' do
            element :panel_title, 'h1', text: 'Your application has been submitted'
            element :panel_body, 'span', text: 'Your reference code is:'
            element :p_1, 'p', text: ' Your application has been sent to Milton Keynes County Court and Family Court.'
            element :header_1, 'h2', text: 'Download a copy of your application'
            element :p_2, 'p', text: 'If you cannot open the PDF file after downloading, download and install Adobe Acrobat Reader to try again.'
            element :link_1, 'a', text: 'Adobe Acrobat Reader'
            element :inset_text, 'div', text: 'If you want to keep a copy, you must download it now. You cannot return to a submitted application. '
            element :download_button, 'button', text: 'Download your application'
            element :header_2, 'h2', text: 'Pay the application fee'
            element :p_3, 'p', text: 'You may not need to pay the full amount if you have a ‘Help with fees’ reference. The court will phone you (it may come from a ‘private number’) if they require payment.'
            element :link_2, 'a', text: '‘Help with fees’'
            element :header_3, 'h2', text: 'Send your proposed agreement for the consent order'
            element :p_4, 'p', text: 'As you are applying for a consent order, you need to send your agreement to the court. You can do this by email or post. If you post it, please send 3 copies.'
            element :header_4, 'h2', text: 'If you’re sending documents'
            element :p_5, 'p', text: 'Remember to include your application reference code. Send documents to:'
            element :link_3, 'a', text: 'C100applications@justice.gov.uk'
            element :header_5, 'h2', text: 'If you need help'
            element :p_6, 'p', text: ' You can contact the court if you need help with your application. Court staff can’t give legal advice so you’ll need to find a legal advisor if you have any issues.'
            element :link_4, 'a', text: 'find a legal advisor'
            element :dd_1, 'dd', text: 'Email'
            element :link_5, 'a', text: 'family.miltonkeynes.countycourt@justice.gov.uk'
            element :dd_2, 'dd', text: 'More information'
            element :link_6, 'a', text: 'Milton Keynes County Court and Family Court'
            element :header_6, 'h2', text: 'We’d like your feedback'
            element :p_7, 'p', text: 'This will help us to improve the service. Your feedback won’t affect your application in any way.'
          end
        end
      end
    end
  end
end
