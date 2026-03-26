class ApplicationDetailsPage < BasePage
 set_url '/steps/application/details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Address of'
    element :details, 'textarea[name="steps_application_details_form[application_details]"]'
    element :continue_button, "button", text: "Continue"
  end

  def submit_details(reason)
    content.details.set reason
    content.continue_button.click
  end
end