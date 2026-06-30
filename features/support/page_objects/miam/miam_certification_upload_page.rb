class MiamCertificationUploadPage < UploadPage
  set_url '/steps/miam/certification_upload'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Upload your MIAM certificate'
  end
end
