class AbductionPassportDetailsPage < BasePage
  set_url '/steps/abduction/passport_details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Provide details of the children’s passports'
    element :multiple_passports_yes, '#steps-abduction-passport-details-form-children-multiple-passports-yes-field', visible: false
    element :multiple_passports_no, '#steps-abduction-passport-details-form-children-multiple-passports-no-field', visible: false
    element :possession_mother, '#steps-abduction-passport-details-form-passport-possession-mother-field', visible: false
    element :possession_father, '#steps-abduction-passport-details-form-passport-possession-father-field', visible: false
    element :possession_other, '#steps-abduction-passport-details-form-passport-possession-other-field', visible: false
    element :possession_other_details, '#steps-abduction-passport-details-form-passport-possession-other-details-field', visible: false
    element :continue_button, "button", text: "Continue"
  end

  def submit_yes_multiple_passports
    content.multiple_passports_yes.click
  end

  def submit_no_multiple_passports
    content.multiple_passports_no.click
  end

  def submit_passport_possession(possession)
    case possession
    when 'mother'
      content.possession_mother.click
    when 'father'
      content.possession_father.click
    when 'other'
      content.possession_other.click
      content.possession_other_details.set 'Other details'
    end
  end

  def continue_to_next_step
    content.continue_button.click
  end
end