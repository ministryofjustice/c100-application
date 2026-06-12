class UploadPage < BasePage
  section :upload_area, '#main-content' do
    element :upload_input, 'input[type="file"]', visible: false
    element :continue_button, "button", text: "Continue"
  end

  def upload_file(filename)
    upload_area.upload_input.attach_file(filename)
    upload_area.continue_button.click
  end
end