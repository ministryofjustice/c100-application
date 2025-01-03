class PrivacyPreferencesPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/other_party/privacy_preferences'

  section :content, '#main-content' do
    element :header, 'h1', text: /Keeping .*?'s details private/
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
    element :subheader, 'p', text: 'The answers you give in your response will be shared with other people named in this application (the respondents). This will include your contact details.'
    element :legend, 'span', text: /Do you want to keep .*?'s details private from the other people named in the application (the respondents)?/

    element :continue_button, 'button', text: 'Continue'
  end
end
