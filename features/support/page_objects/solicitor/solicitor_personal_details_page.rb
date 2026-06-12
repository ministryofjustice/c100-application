class SolicitorPersonalDetailsPage < BasePage
  set_url '/steps/solicitor/personal_details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Details of solicitor'
    element :full_name_field, "input[name='steps_solicitor_personal_details_form[full_name]']"
    element :firm_name_field, "input[name='steps_solicitor_personal_details_form[firm_name]']"
    element :continue_button, "button", text: "Continue"
  end

  def submit_solicitor_details(full_name:, firm_name:)
    content.full_name_field.set full_name
    content.firm_name_field.set firm_name
    content.continue_button.click
  end

  def submit_personal_details(full_name, firm_name)
    submit_solicitor_details(full_name: full_name, firm_name: firm_name)
  end

  def continue_without_filling
    content.continue_button.click
  end
end