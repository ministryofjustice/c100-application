class ChildPersonalDetailsPage < BasePage
  set_url_matcher %r{/steps/children/personal_details/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'Provide details for'
    element :gender_male, "input#steps-children-personal-details-form-gender-male-field", visible: false
    element :gender_female, "input#steps-children-personal-details-form-gender-female-field", visible: false
    element :gender_unspecified, "input#steps-children-personal-details-form-gender-unspecified-field", visible: false
    element :dob_day, "input[name='steps_children_personal_details_form[dob(3i)]']"
    element :dob_month, "input[name='steps_children_personal_details_form[dob(2i)]']"
    element :dob_year, "input[name='steps_children_personal_details_form[dob(1i)]']"
    element :continue_button, "button", text: "Continue"
  end

  def submit_child_personal_details(gender:, age:)
    if gender == 'male'
      content.gender_male.click
    elsif gender == 'female'
      content.gender_female.click
    else
      content.gender_unspecified.click
    end

    today = Date.today
    date_of_birth = today - age.to_i.years

    content.dob_day.set date_of_birth.day
    content.dob_month.set date_of_birth.month
    content.dob_year.set date_of_birth.year
    content.continue_button.click
  end
end