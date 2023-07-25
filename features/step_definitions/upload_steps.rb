When(/^I upload a document to the MIAM certificate page$/) do
  identifier  = 'steps-miam-certification-upload-form-miam-certificate-document-field'
  filename    = 'features/support/sample_file/image.jpg'
  attach_file(identifier, filename)
end

Then(/^I upload a document to the consent order page$/) do
  identifier  = 'steps-opening-consent-order-upload-form-draft-consent-order-document-field'
  filename    = 'features/support/sample_file/image.jpg'
  attach_file(identifier, filename)
end
