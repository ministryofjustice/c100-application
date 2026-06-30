class SolicitorPersonalDetailsPage < BasePage
  set_url '/steps/solicitor/personal_details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Details of solicitor'
    element :full_name_field, "input[name='steps_solicitor_personal_details_form[full_name]']"
    element :firm_name_field, "input[name='steps_solicitor_personal_details_form[firm_name]']"
  end

  def submit_solicitor_details(full_name:, firm_name:)
    content.full_name_field.set full_name
    content.firm_name_field.set firm_name
    click_continue_button
  end

  def submit_personal_details(full_name, firm_name)
    submit_solicitor_details(full_name: full_name, firm_name: firm_name)
  end

  def continue_without_filling
    click_continue_button
  end
end
