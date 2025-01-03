class SafetyPlaybackPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/miam_exemptions/safety_playback'

  section :content, '#main-content' do
    element :header, 'h1', text: 'You don’t have to attend a MIAM'
    element :subheader, 'p', text: 'You have safety concerns.'
    element :p, 'p', text: 'You’ve told us:'
    element :inset_text, 'div', text: 'The court will review your situation and may contact you to discuss your concerns. You may still need to attend a MIAM if valid reasons aren’t provided.'

    element :continue_button, 'button', text: 'Continue'
  end
end
