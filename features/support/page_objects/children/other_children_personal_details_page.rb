class OtherChildrenPersonalDetailsPage < ChildPersonalDetailsPage
  set_url_matcher %r{/steps/other_children/personal_details/.*}

  element :gender_male, "input#steps-other-children-personal-details-form-gender-male-field", visible: false
  element :gender_female, "input#steps-other-children-personal-details-form-gender-female-field", visible: false
  element :gender_unspecified, "input#steps-other-children-personal-details-form-gender-unspecified-field", visible: false
  element :dob_day, "input[name='steps_other_children_personal_details_form[dob(3i)]']"
  element :dob_month, "input[name='steps_other_children_personal_details_form[dob(2i)]']"
  element :dob_year, "input[name='steps_other_children_personal_details_form[dob(1i)]']"
end