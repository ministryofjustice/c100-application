class ApplicationDetailsPage < BasePage
  set_url '/steps/application/details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Address of'
    element :details, 'textarea[name="steps_application_details_form[application_details]"]'
  end

  def submit_details(reason)
    content.details.set reason
    click_continue_button
  end
end
