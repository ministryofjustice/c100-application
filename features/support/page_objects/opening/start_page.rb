require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Opening
        class StartPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/opening/start'

          section :content, '#main-content' do
            element :span_1, 'span', text: 'Before you continue'
            element :header, 'h1', text: 'What you’ll need to complete your application'
            element :intro_text, 'p', text: 'You will need to pay the court fee of £255'
            element :link_1, 'a', text: 'get help paying'
            element :list_start, 'p', text: 'You will need the following:'
            element :list_item_1, 'li', text: 'details of the other people (the respondents), including their date of birth'
            element :list_item_2, 'li', text: 'the child’s or children’s details, including date of birth'
            element :list_item_3, 'li', text: 'contact details of the respondents, including their current address'
            element :list_item_4, 'li', text: 'solicitor details (if you have asked one to represent you)'
            element :list_item_5, 'li', text: 'details of any previous family court cases'
            element :list_item_6, 'li', text: 'signed document confirming MIAM attendance (if applicable)'
            element :list_item_7, 'li', text: 'a scan, photo or electronic copy of the document confirming MIAM attendance if you are applying for a child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order (if applicable)'
            element :list_item_8, 'li', text: 'written agreement signed by both parties for the court to formalise if you are applying for a consent order '
            element :list_item_9, 'li', text: 'a scan, photo or electronic copy of your draft consent order if you are applying for a consent order'
            element :list_item_10, 'li', text: 'evidence for a MIAM exemption if needed'
            element :list_item_11, 'li', text: 'completed and signed certificate of suitability or copy of the court order appointing a ‘litigation friend’ if any of the people making this application are under 18'
            element :link_2, 'a', text: 'certificate of suitability'
            element :list_end, 'p', text: 'If you are applying for a consent order you must have a written agreement signed by you and the respondent for the court to formalise.'
            element :inset_text_1, 'p', text: 'If you do not know all of the details you can still complete your application but it will take longer to process.'
            element :inset_text_2, 'p', text: 'If you are currently involved in Child Arrangements, Prohibited Steps or Specific Issue Order proceeding for the same child or children you can apply to the same court using the shorter form C2. Please make sure you state the case number when you submit the form.'

            element :continue_link, 'a', text: 'Continue'
            element :resume_link, 'a', text: 'Or return to a saved application'
          end
        end
      end
    end
  end
end
