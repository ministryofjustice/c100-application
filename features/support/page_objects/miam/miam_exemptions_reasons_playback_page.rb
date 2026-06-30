class MiamExemptionsReasonsPlaybackPage < BasePage
  set_url '/steps/miam_exemptions/reasons_playback'

  section :content, '#main-content' do
    element :header, 'h1', text: 'You don’t have to attend a MIAM'
  end
end
