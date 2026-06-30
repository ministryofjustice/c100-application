class ApplicantPrivacySummaryPage < BasePage
  set_url_matcher %r{/steps/applicant/privacy_summary/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'The court will not keep your contact details private'
  end
end
