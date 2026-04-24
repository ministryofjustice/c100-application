class MiamExemptionsExemptionUploadPage < BasePage
  set_url '/steps/miam_exemptions/exemption_upload'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Upload your evidence for a MIAM exemption'
    element :upload_input, 'input[type="file"]', visible: false
    element :continue_button, "button", text: "Continue"
  end

  def upload_file(filename)
    content.upload_input.attach_file(filename)
    content.continue_button.click
  end
end