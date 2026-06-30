class OtherPartyIdentityPreferencesPage < YesNoPage
  set_url_matcher %r{/steps/other_party/identity_preferences/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'identity private'
  end
end
