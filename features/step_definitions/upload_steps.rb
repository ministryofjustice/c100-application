When(/^I upload a document to the MIAM certificate page$/) do
  identifier  = 'steps-miam-certification-upload-form-miam-certificate-document-field'
  filename    = 'features/support/sample_file/image.jpg'
  attach_file(identifier, filename)
end