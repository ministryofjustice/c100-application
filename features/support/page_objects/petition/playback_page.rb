class PlaybackPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/petition/playback'

  section :content, '#main-content' do
    element :header, 'h1', text: 'What you’re asking the court to decide about the children'

    element :continue_button, 'button', text: 'Continue'
  end
end
