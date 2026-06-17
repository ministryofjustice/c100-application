class ExistingCourtOrderUploadPage < UploadPage
  set_url '/steps/application/existing_court_order_upload'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Upload your existing court order'
  end
end
