class ApplicantPersonalDetailsPage < BasePage
  set_url '/steps/applicant/personal_details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Provide details for'
    element :has_previous_name_yes, "input#steps-applicant-personal-details-form-has-previous-name-yes-field", visible: false
    element :has_previous_name_no, "input#steps-applicant-personal-details-form-has-previous-name-no-field", visible: false
    element :previous_name_field, "input[name='steps_applicant_personal_details_form[previous_name]']"
    element :gender_male, "input#steps-applicant-personal-details-form-gender-male-field", visible: false
    element :gender_female, "input#steps-applicant-personal-details-form-gender-female-field", visible: false
    element :dob_day, "input[name='steps_applicant_personal_details_form[dob(3i)]']"
    element :dob_month, "input[name='steps_applicant_personal_details_form[dob(2i)]']"
    element :dob_year, "input[name='steps_applicant_personal_details_form[dob(1i)]']"
    element :birthplace_field, "input[name='steps_applicant_personal_details_form[birthplace]']"
    element :continue_button, "button", text: "Continue"
  end

  def submit_personal_details(
    has_previous_name:,
    previous_name: nil,
    gender:, day: nil,
    month: nil,
    year: nil,
    birthplace:,
    age: nil
  )
    if has_previous_name == 'yes'
      content.has_previous_name_yes.click
      content.previous_name_field.set previous_name
    else
      content.has_previous_name_no.click
    end

    if gender == 'male'
      content.gender_male.click
    else
      content.gender_female.click
    end

    if age.present?
      today = Date.today
      day = today.day
      month = today.month
      year = (today - age.to_i.years).year
    end

    content.dob_day.set day
    content.dob_month.set month
    content.dob_year.set year
    content.birthplace_field.set birthplace
    content.continue_button.click
  end

  def continue_without_filling
    content.continue_button.click
  end
end