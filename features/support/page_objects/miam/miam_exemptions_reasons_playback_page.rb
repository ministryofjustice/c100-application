class MiamExemptionsReasonsPlaybackPage < BasePage
  set_url '/steps/miam_exemptions/reasons_playback'

  section :content, '#main-content' do
    element :header, 'h1', text: 'You don’t have to attend a MIAM'
    element :continue_button, "a", text: "Continue"
  end

  def continue
    content.continue_button.click
  end
end