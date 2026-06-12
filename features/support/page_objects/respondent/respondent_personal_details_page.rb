class RespondentPersonalDetailsPage < BasePage
  set_url_matcher %r{steps/respondent/personal_details/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'Provide details for'
    element :has_previous_name_yes, "input#steps-respondent-personal-details-form-has-previous-name-yes-field", visible: false
    element :has_previous_name_no, "input#steps-respondent-personal-details-form-has-previous-name-no-field", visible: false
    element :gender_female, "input#steps-respondent-personal-details-form-gender-female-field", visible: false
    element :gender_male, "input#steps-respondent-personal-details-form-gender-male-field", visible: false
    element :gender_unspecified, "input#steps-respondent-personal-details-form-gender-unspecified-field", visible: false
    element :dob_day, "input#steps_respondent_personal_details_form_dob_3i"
    element :dob_month, "input#steps_respondent_personal_details_form_dob_2i"
    element :dob_year, "input#steps_respondent_personal_details_form_dob_1i"
    element :birthplace_field, "input#steps-respondent-personal-details-form-birthplace-field"
    element :continue_button, "button", text: "Continue"
  end

  def submit_personal_details(has_previous_name:, gender:, age:, birthplace:)
    if has_previous_name == 'yes'
      content.has_previous_name_yes.click
    else
      content.has_previous_name_no.click
    end

    if gender == 'male'
      content.gender_male.click
    else
      content.gender_female.click
    end

    age = age.to_i
    today = Date.today
    year = today.year - age
    month = today.month
    day = today.day
    
    content.dob_day.set day
    content.dob_month.set month
    content.dob_year.set year
    content.birthplace_field.set birthplace
    content.continue_button.click
  end
end