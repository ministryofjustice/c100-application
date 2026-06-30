class LitigationCapacityDetailsPage < BasePage
  set_url "/steps/application/litigation_capacity_details"

  section :content, '#main-content' do
    element :header, "h1", text: "Factors affecting ability to participate"
    element :participation_capacity_details,
            "textarea[name='steps_application_litigation_capacity_details_form[participation_capacity_details]']"
    element :participation_other_factors_details,
            "textarea[name='steps_application_litigation_capacity_details_form[participation_other_factors_details]']"
    element :participation_referral_or_assessment_details,
            "textarea[name='steps_application_litigation_capacity_details_form[participation_referral_or_assessment_details]']"
  end

  def submit(participation_capacity_details:, participation_other_factors_details:, participation_referral_or_assessment_details:)
    content.participation_capacity_details.set(participation_capacity_details)
    content.participation_other_factors_details.set(participation_other_factors_details)
    content.participation_referral_or_assessment_details.set(participation_referral_or_assessment_details)
    click_continue_button
  end

  def continue_without_filling
    click_continue_button
  end
end
