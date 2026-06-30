class OtherPartyPersonalDetailsPage < BasePage
  set_url_matcher %r{/steps/other_party/personal_details/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'Provide details for'
    element :has_previous_name_yes, "input#steps-other-party-personal-details-form-has-previous-name-yes-field", visible: false
    element :has_previous_name_no, "input#steps-other-party-personal-details-form-has-previous-name-no-field", visible: false
    element :gender_female, "input#steps-other-party-personal-details-form-gender-female-field", visible: false
    element :gender_male, "input#steps-other-party-personal-details-form-gender-male-field", visible: false
    element :gender_unspecified, "input#steps-other-party-personal-details-form-gender-unspecified-field", visible: false
    element :dob_day, "input[name='steps_other_party_personal_details_form[dob(3i)]']"
    element :dob_month, "input[name='steps_other_party_personal_details_form[dob(2i)]']"
    element :dob_year, "input[name='steps_other_party_personal_details_form[dob(1i)]']"
  end

  def submit_personal_details(gender:, age:, has_previous_name: false)
    if has_previous_name
      content.has_previous_name_yes.click
    else
      content.has_previous_name_no.click
    end

    if gender == 'male'
      content.gender_male.click
    elsif gender == 'female'
      content.gender_female.click
    else
      content.gender_unspecified.click
    end

    age = age.to_i
    today = Date.today
    year = today.year - age
    month = today.month
    day = today.day

    content.dob_day.set day
    content.dob_month.set month
    content.dob_year.set year
    click_continue_button
  end
end
