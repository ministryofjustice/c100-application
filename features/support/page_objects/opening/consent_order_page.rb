class ConsentOrderPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/opening/consent_order'

  section :content, '#main-content' do
    element :header, 'h1', text: 'What kind of application do you want to make?'
    element :subheader, 'p', text: 'You can apply to court for the following orders.'
    element :label_1, 'label', text: 'Child arrangements order, prohibited steps order, specific issue order, or to change or end an existing order'
    element :hint_1, 'p', text: 'This includes deciding who the children live with and where; stopping someone doing something; and resolving a specific matter.'
    element :hint_2, 'p', text: 'If you select this option, you must have a scan, photo or electronic copy of the of the document confirming MIAM attendance which you are able to upload to this application or a valid reason for not attending.'
    element :label_2, 'label', text: 'Consent order'
    element :hint_3, 'p', text: 'This includes deciding who the children live with and where; stopping someone doing something; and resolving a specific matter.'
    element :hint_4, 'p', text: 'This makes a written agreement legally binding; it must be signed by you (the applicant) and the other person (respondent). If you select this option, you must have a scan, photo or electronic copy of the draft consent order signed by the respondent which you are able to upload to this application.'

    element :continue_button, 'button', text: 'Continue'
  end
end
