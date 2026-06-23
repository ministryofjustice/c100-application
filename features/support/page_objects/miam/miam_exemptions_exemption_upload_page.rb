class MiamExemptionsExemptionUploadPage < UploadPage
  set_url '/steps/miam_exemptions/exemption_upload'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Upload your evidence for a MIAM exemption'
  end
end
