class UploadPage < BasePage
  section :upload_area, '#main-content' do
    element :upload_input, 'input[type="file"]', visible: false
  end

  def upload_file(filename)
    upload_area.upload_input.attach_file(filename)
    click_continue_button
  end
end
