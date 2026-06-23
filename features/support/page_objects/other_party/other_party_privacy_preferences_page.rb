class OtherPartyPrivacyPreferencesPage < YesNoPage
  set_url_matcher %r{/steps/other_party/privacy_preferences/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'contact details private'
  end
end
