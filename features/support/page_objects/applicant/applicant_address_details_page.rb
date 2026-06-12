class ApplicantAddressDetailsPage < BasePage
  set_url '/steps/applicant/address_details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Address details of'
    element :address_line_1_field, "input[name='steps_applicant_address_details_form[address_line_1]']"
    element :town_field, "input[name='steps_applicant_address_details_form[town]']"
    element :country_field, "input[name='steps_applicant_address_details_form[country]']"
    element :residence_requirement_yes, "input[name='steps_applicant_address_details_form[residence_requirement_met]'][value='yes']", visible: false
    element :residence_requirement_no, "input[name='steps_applicant_address_details_form[residence_requirement_met]'][value='no']", visible: false
    element :continue_button, "button", text: "Continue"
  end

  def submit_address_details(address_line_1:, town:, country:, residence_5_years:)
    content.address_line_1_field.set address_line_1
    content.town_field.set town
    content.country_field.set country
    
    if residence_5_years == 'yes'
      content.residence_requirement_yes.click
    else
      content.residence_requirement_no.click
    end
    
    content.continue_button.click
  end

  def continue_without_filling
    content.continue_button.click
  end
end