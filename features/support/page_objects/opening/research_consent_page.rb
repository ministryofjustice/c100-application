class ResearchConsentPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/opening/research_consent'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Are you willing to be contacted to share your experience of using this service?'
    element :legend, 'div', text: 'Your insights will help us improve the service.'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
    element :span, 'span', text: 'What happens if you choose to be contacted'
    element :p_1, 'p', text: 'By choosing to be contacted by the Ministry of Justice (MOJ) you agree that your personal details and any information you give can be used by MOJ for research purposes.'
    element :subheader_1, 'h2', text: 'The information we use'
    element :p_2, 'p', text: 'MOJ can use any information you provide, including your name and contact information (such as your email address).'
    element :subheader_2, 'h2', text: 'Why we use this information'
    element :p_3, 'p', text: 'To get your thoughts on this service - for example, we might send you a satisfaction survey.'
    element :subheader_3, 'h2', text: 'Data and your rights'
    element :p_4, 'p', text: 'You can find out how long we keep your data, your rights and how to contact us in our privacy policy.'
    element :link, 'a', text: 'privacy policy'

    element :continue_button, 'button', text: 'Continue'
  end
end
