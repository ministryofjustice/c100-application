class PreviousCourtProceedingsPage < BasePage
  set_url '/steps/application/court_proceedings'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have any of the children in this application been involved in other family court proceedings?'
    element :children_names, 'textarea[name="steps_application_court_proceedings_form[children_names]"]'
    element :court_name, 'input[name="steps_application_court_proceedings_form[court_name]"]'
    element :proceedings_date, 'input[name="steps_application_court_proceedings_form[proceedings_date]"]'
    element :proceedings_type, 'textarea[name="steps_application_court_proceedings_form[order_types]"]'
    element :details, 'textarea[name="steps_application_court_proceedings_form[previous_details]"]'  
    element :continue_button, "button", text: "Continue"
  end

  def submit_previous_proceedings(children_names:, court_name:, proceedings_date:, proceedings_type:, details:)
    content.children_names.set children_names
    content.court_name.set court_name
    content.proceedings_date.set proceedings_date
    content.proceedings_type.set proceedings_type
    content.details.set details
    content.continue_button.click
  end
end