class CheckYourAnswersPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/application/check_your_answers'

  section :content, '#main-content' do
    element :header_1, 'h1', text: 'Check your answers'
    element :subheader_1, 'p', text: 'Please review your answers before you finish your application.'
    element :header_2, 'h2', text: 'Statement of Truth'
    element :subheader_2, 'p', text: 'I understand that proceedings for contempt of court may be brought against anyone who makes, or causes to be made, a false statement in a document verified by a statement of truth without an honest belief in its truth.'
    element :label_1, 'label', text: 'I believe that the facts stated in this form and any continuation sheet are true'
    element :label_2, 'label', text: 'The applicant believes that the facts stated in this form and any continuation sheets are true.I am authorised by the applicant to sign this statement.This option should only selected if the legal representative is signing the form on behalf of the applicant.'
    element :label_3, 'label', text: 'Enter your full name'
    element :inset_text_1, 'p', text: 'Once you submit your application, you cannot make any further changes. Please select \'Save and come back later\' to save your application before selecting \'Continue\' to complete your online application.'
    element :inset_text_2, 'p', text: 'You can download a copy of your submitted application on the next page.'
    element :submit_button, 'button', text: 'Submit application'
    element :span, 'span', text: 'Download a draft of your application (PDF)'
    element :inset_text_3, 'p', text: 'If you cannot open the PDF file after downloading, download and install Adobe Acrobat Reader to try again.'
    element :link, 'a', text: ' Adobe Acrobat Reader'
    element :inset_text_4, 'p', text: 'Please note this draft is for your records. Only the completed application will be admitted in court.'
    element :download_button, 'a', text: 'Download draft application'
  end
end
