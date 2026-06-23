class ApplicantHasSolicitorPage < YesNoPage
  set_url '/steps/applicant/has_solicitor'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Will you be legally represented by a solicitor in these proceedings?'
  end
end
