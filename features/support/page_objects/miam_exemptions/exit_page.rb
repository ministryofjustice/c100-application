class ExitPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/miam_exemptions/exit_page'

  section :content, '#main-content' do
    element :header_1, 'h1', text: 'You must attend a MIAM'
    element :subheader, 'p', text: 'You have not provided a valid reason for not attending a MIAM or another form of NCDR. You’re legally required to attend one if you want to go to court to resolve a dispute involving the children.'
    element :p_1, 'p', text: 'You need to follow these steps before continuing with your application:'
    element :label_1, 'label', text: 'Enter your postcode to find a mediator'
    element :mediator_button, 'button', text: 'Find a mediator'
    element :label_2, 'label', text: 'Book initial meeting with mediator'
    element :label_3, 'label', text: 'Attend the MIAM'
    element :label_4, 'label', text: 'Ask the mediator for a document confirming your attendance'
    element :p_2, 'p', text: 'Alternatively you can read the child arrangements guide to see if there’s a more suitable option than going to court.'
    element :link_1, 'a', text: 'read the child arrangements guide'
    element :header_2, 'h2', text: 'We’d like your feedback'
    element :p_3, 'p', text: 'Would you like to complete a 5-minute survey to give us your feedback about the online service you have just used? This will help us to improve it.'
    element :link_2, 'a', text: 'complete a 5-minute survey'
  end
end
