class ExistingCourtOrderUploadablePage < YesNoPage
  set_url '/steps/application/existing_court_order_uploadable'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Can you upload your existing court order?'
  end
end