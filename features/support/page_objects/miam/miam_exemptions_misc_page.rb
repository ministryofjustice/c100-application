class MiamExemptionsMiscPage < BasePage
  set_url '/steps/miam_exemptions/misc'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Confirming other valid reasons for not attending'
    element :applicant_respondent_under_age,
            'input[name="steps_miam_exemptions_misc_form[misc][]"][value="misc_applicant_under_age"]', visible: false
    element :without_notice_hearing, 'input[name="steps_miam_exemptions_misc_form[misc][]"][value="misc_without_notice"]',
            visible: false
    element :misc_none, 'input[name="steps_miam_exemptions_misc_form[misc][]"][value="misc_none"]', visible: false
  end

  def submit_applicant_respondent_under_age
    content.applicant_respondent_under_age.click
    click_continue_button
  end

  def submit_without_notice_hearing
    content.without_notice_hearing.click
    click_continue_button
  end

  def submit_none_of_these
    content.misc_none.click
    click_continue_button
  end
end
