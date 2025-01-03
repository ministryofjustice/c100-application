class WhatNextPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/completion/what_next'

  section :content, '#main-content' do
    element :header_1, 'h1', text: 'How to submit your application'
    element :warning_text, 'span', text: 'Warning The court will not receive your application until you complete the steps below.'
    element :header_2, 'h3', text: 'Download your application'
    element :p_1, 'p', text: 'If you cannot open the PDF file after downloading, download and install Adobe Acrobat Reader to try again.'
    element :inset_text, 'div', text: 'To avoid losing your application, you must download it now. You cannot return to a completed application.'
    element :download_button, 'button', text: 'Download your application'
    element :header_3, 'h3', text: 'Print your application and proposed agreement for the consent order'
    element :p_2, 'p', text: 'Print 3 copies of your whole application on A4 paper, single sided. The court will send one copy to the other person, keep one copy, and return one copy to you.'
    element :p_3, 'p', text: 'You must also send 3 copies of your proposed agreement for the consent order.'
    element :header_4, 'h3', text: 'Post it to the court'
    element :p_4, 'p', text: 'Post all 3 printed copies of your application to:'
    element :header_5, 'h3', text: 'Pay the application fee'
    element :p_5, 'p', text: 'You may not need to pay the full amount if you have a ‘Help with fees’ reference. The court will phone you (it may come from a ‘private number’) if they require payment.'
    element :link_1, 'a', text: '‘Help with fees’'
    element :header_6, 'h2', text: 'If you need help'
    element :p_6, 'p', text: 'You can contact the court if you need help with your application. Court staff can’t give legal advice so you’ll need to find a legal advisor if you have any issues.'
    element :link_2, 'a', text: 'find a legal advisor'
    element :dd_1, 'dd', text: 'Email'
    element :link_3, 'a', text: 'family.miltonkeynes.countycourt@justice.gov.uk'
    element :dd_2, 'dd', text: 'More information'
    element :link_4, 'a', text: 'Milton Keynes County Court and Family Court'
    element :header_7, 'h2', text: 'We’d like your feedback'
    element :p_7, 'p', text: 'This will help us to improve the service. Your feedback won’t affect your application in any way.'
  end
end
