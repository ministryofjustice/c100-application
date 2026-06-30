class AbductionPassportDetailsPage < BasePage
  set_url '/steps/abduction/passport_details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Provide details of the children’s passports'
    element :multiple_passports_yes, '#steps-abduction-passport-details-form-children-multiple-passports-yes-field',
            visible: false
    element :multiple_passports_no, '#steps-abduction-passport-details-form-children-multiple-passports-no-field', visible: false
    element :possession_mother, '#steps-abduction-passport-details-form-passport-possession-mother-field', visible: false
    element :possession_father, '#steps-abduction-passport-details-form-passport-possession-father-field', visible: false
    element :possession_other, '#steps-abduction-passport-details-form-passport-possession-other-field', visible: false
    element :possession_other_details, '#steps-abduction-passport-details-form-passport-possession-other-details-field',
            visible: false
  end

  def select_yes_multiple_passports
    content.multiple_passports_yes.click
  end

  def select_no_multiple_passports
    content.multiple_passports_no.click
  end

  def select_passport_possession(possession)
    if possession == 'mother'
      content.possession_mother.click
    elsif possession == 'father'
      content.possession_father.click
    elsif possession == 'other'
      content.possession_other.click
      content.possession_other_details.set 'Other details'
    end
  end
end
