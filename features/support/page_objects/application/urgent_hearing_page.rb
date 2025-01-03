require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module Application
        class UrgentHearingPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/application/urgent_hearing'

          section :content, '#main-content' do
            element :header, 'h1', text: 'Do you need an urgent hearing?'
            element :p_1, 'p', text: 'A hearing will usually take place within 5 or 6 weeks of the court processing your application. You can ask for a hearing to take place sooner and a court will consider if there’s good reason for the urgency, for example:'
            element :li_1, 'li', text: 'there’s a risk of harm to you or the children'
            element :li_2, 'li', text: 'the children are at risk of abduction'
            element :li_3, 'li', text: 'there may be an immediate risk of harm to you or the child. Otherwise, in many cases the first hearing will take place within 2 months. The court will determine whether your case requires an urgent hearing'
            element :inset_text, 'div', text: 'Contact the police if you or the children are in immediate danger.'
            element :span, 'span', text: 'Examples of when a court may consider an urgent hearing'
            element :p_2, 'p', text: 'There is:'
            element :li_4, 'li', text: 'risk to the life, liberty or physical safety of you, your family or your home'
            element :li_5, 'li', text: 'significant risk that proceedings relating to the dispute will be brought in another country'
            element :li_6, 'li', text: 'there may be an immediate risk of harm to you or the child. Otherwise, in many cases the first hearing will take place within 2 months. The court will determine whether your case requires an urgent hearing'
            element :p_3, 'p', text: 'Any delay would cause:'
            element :li_7, 'li', text: 'a risk of harm to the children'
            element :li_8, 'li', text: 'significant financial hardship to the prospective applicant'
            element :li_9, 'li', text: 'a risk of unlawful removal of a child from the UK, or a risk of unlawful retention of a child who is currently outside England and Wales'
            element :li_10, 'li', text: 'a significant risk of a miscarriage of justice'
            element :li_11, 'li', text: 'irretrievable problems in dealing with the dispute (including the irretrievable loss of significant evidence)'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
