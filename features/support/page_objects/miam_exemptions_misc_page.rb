class MiamExemptionsMiscPage < BasePage
  set_url '/steps/miam_exemptions/misc'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Confirming other valid reasons for not attending'
    element :applicant_respondent_under_age, 'input[name="steps_miam_exemptions_misc_form[misc][]"][value="misc_applicant_under_age"]', visible: false
    element :misc_none, 'input[name="steps_miam_exemptions_misc_form[misc][]"][value="misc_none"]', visible: false
    element :continue_button, "button", text: "Continue"
  end

  def submit_applicant_respondent_under_age
    content.applicant_respondent_under_age.click
    content.continue_button.click
  end

  def submit_none_of_these
    content.misc_none.click
    content.continue_button.click
  end
end