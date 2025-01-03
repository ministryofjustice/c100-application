class NoCourtFoundPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/opening/no_court_found'

  section :content, '#main-content' do
    element :header_1, 'h1', text: 'Sorry, you cannot apply online'
    element :subheader, 'p', text: 'This service is only available in England and Wales.'
    element :p_1, 'p', text: 'If the child or children live in Scotland or Northern Ireland, you will not be able to use this service to submit your application.'
    element :p_2, 'p', text: 'If you think there’s been an error finding an appropriate court, you can report the problem.'
    element :link_1, 'a', text: 'report the problem'
    element :header_2, 'h2', text: 'What to do now'
    element :p_3, 'p', text: 'To submit an application in England or Wales, you’ll need to complete the C100 paper form, print it and send it by post.'
    element :p_4, 'p', text: 'Alternatively you can read the child arrangements guide to see if there’s a more suitable option than going to court.'
    element :link_2, 'a', text: 'read the child arrangements guide'

    element :download_button, 'button', text: 'Download the form (PDF)'
  end
end
