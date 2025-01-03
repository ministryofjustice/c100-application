require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module MiamExemptions
        class DomesticPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/miam_exemptions/domestic'

          section :content, '#main-content' do
            element :caption, 'span', text: 'MIAM exemptions'
            element :header, 'h1', text: 'Providing evidence of domestic abuse concerns'
            element :p_1, 'p', text: 'You’ve told us you have a valid reason for not attending a MIAM. The following questions will ask what evidence you have in support of this.'
            element :p_2, 'p', text: 'Where it is required, evidence of the claimed MIAM exemption(s) must be uploaded with this application to court.'
            element :legend, 'span', text: 'Does the prospective applicant have any of the following evidence of domestic abuse?'
            element :hint_1, 'div', text: 'Select all that apply or ‘None of these’'
            element :label_1, 'label', text: 'The police have been involved.'
            element :hint_2, 'div', text: 'For example, you or the other people in this application (the respondents) have been arrested, cautioned, charged or convicted for domestic or child abuse offences.'
            element :label_2, 'label', text: 'A court has already been involved.'
            element :hint_3, 'div', text: 'For example, a court has made an order relating to the prospective applicant, the other people in this application (the respondents) or somebody close to you or them in connection with domestic abuse.'
            element :label_3, 'label', text: 'A letter confirms the prospective applicant or the other people in this application (the respondents) are or have been a victim of domestic abuse.'
            element :hint_4, 'div', text: 'For example, a health professional or specialist has confirmed injuries that are or were a result of domestic abuse.'
            element :label_4, 'label', text: 'A letter from a local authority or other agency confirms a risk of harm.'
            element :hint_5, 'div', text: 'For example, a local authority or housing association has confirmed there is or has been a risk of domestic abuse.'
            element :label_5, 'label', text: 'The prospective applicant has a letter from a domestic abuse support service, specialist or organisation.'
            element :hint_6, 'div', text: 'For example, an independent domestic violence advisor (IDVA) has confirmed support to you or the other people in this application (the respondents).'
            element :label_6, 'label', text: 'The prospective applicant or any of the other people in this application (the respondents) have been granted indefinite leave to remain in the UK as a victim of domestic abuse.'
            element :hint_7, 'label', text: 'A letter from the Home Office will have confirmed that the leave was granted.'
            element :label_7, 'label', text: 'You have evidence that the prospective applicant or the other people in this application (the respondents) have been, or are at risk of being, financially abused by the other.'
            element :hint_8, 'div', text: 'Financial abuse is a way of controlling someone being able to earn, spend or keep their own money. For example, preventing someone going to work, withholding money, or putting debts in someone else’s name. Evidence could include:'
            element :li_1, 'li', text: 'a copy of a credit card account, loan document or bank statements'
            element :li_2, 'li', text: 'a letter from a domestic abuse support organisation'
            element :li_3, 'li', text: 'emails, text messages or a diary kept by the victim'
            element :radio_divider, 'div', text: 'or'
            element :label_8, 'label', text: 'None of these'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
