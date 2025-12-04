Then(/^I upload a document using the file uploader$/) do
  filename = File.absolute_path('features/support/sample_file/image.jpg')

  within(".govuk-drop-zone") do
    find('input[type="file"]', visible: false).attach_file(filename)
  end
end