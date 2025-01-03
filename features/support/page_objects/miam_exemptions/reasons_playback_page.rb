class ReasonsPlaybackPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/miam_exemptions/reasons_playback'

  section :content, '#main-content' do
    element :header, 'h1', text: 'You don’t have to attend a MIAM'
    element :subheader, 'p', text: 'You’ve said you have a valid reason for not attending a MIAM.'
    element :p, 'p', text: 'The reasons you’ve given are:'
    element :inset_text, 'div', text: 'You’ll be asked to provide more information about your circumstances at the first court hearing. Where evidence is needed to support an exemption, you will need to submit a copy of this evidence with your application to the court or explain the reasons why you cannot provide it.'

    element :continue_button, 'button', text: 'Continue'
  end
end
