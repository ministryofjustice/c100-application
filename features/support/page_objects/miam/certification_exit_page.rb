require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Miam
        class CertificationExitPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/miam/certification_exit'

          section :content, '#main-content' do
            element :header, 'h1', text: 'You need to get a document from the mediator'
            element :subheader, 'p', text: 'Ask the mediator to provide you with a signed document confirming you attended a MIAM.'
            element :p, 'p', text: 'When you have a document from the mediator, return to continue with your application.'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
