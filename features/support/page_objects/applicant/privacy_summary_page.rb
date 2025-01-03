class PrivacySummaryPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/applicant/privacy_summary'

  section :content, '#main-content' do
    element :header, 'h1', text: /^(The court will (not )?keep your contact details private)$/
    element :p, 'p', text: /^(You have told us that either the other people named in this application do not know any of your contact details, or you do not want to keep your contact details private from the other people named in this application \(the respondents\)\.|You have told us you want to keep these contact details private)$/

    element :continue_button, 'button', text: 'Continue'
  end
end
