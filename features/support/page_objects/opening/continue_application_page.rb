class ContinueApplicationPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/opening/continue_application'

  section :content, '#main-content' do
    element :header_1, 'h1', text: 'Continue an application'
    element :subheader, 'h2', text: 'If you are continuing a pending application, sign in with the relevant service:'
    element :label_1, 'label', text: 'Sign in to your MyHMCTS account'
    element :label_2, 'label', text: 'Sign in using the GOV.UK service'
    element :span, 'span', text: 'Contact us for help'
    element :header_2, 'h3', text: 'Get in touch'
    element :link_1, 'a', text: 'C100applications@justice.gov.uk'
    element :link_2, 'a', text: 'contact the relevant court'

    element :continue_button, 'button', text: 'Continue'
  end
end
