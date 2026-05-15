class WithoutNoticeDetailsPage < BasePage
  set_url '/steps/application/without_notice_details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Details of without notice hearing'
    element :details, 'textarea[name="steps_application_without_notice_details_form[without_notice_details]"]'
    element :possible_frustrate_yes, 'input[name="steps_application_without_notice_details_form[without_notice_frustrate]"][value="yes"]', visible: false
    element :possible_frustrate_no, 'input[name="steps_application_without_notice_details_form[without_notice_frustrate]"][value="no"]', visible: false
    element :possible_frustrate_details, 'textarea[name="steps_application_without_notice_details_form[without_notice_frustrate_details]"]', visible: false
    element :without_notice_impossible_yes, 'input[name="steps_application_without_notice_details_form[without_notice_impossible]"][value="yes"]', visible: false
    element :without_notice_impossible_no, 'input[name="steps_application_without_notice_details_form[without_notice_impossible]"][value="no"]', visible: false
    element :without_notice_impossible_details, 'textarea[name="steps_application_without_notice_details_form[without_notice_impossible_details]"]', visible: false
    element :continue_button, 'button', text: 'Continue'
  end

  def submit(details:, possible_frustrate: false, possible_frustrate_details: nil, without_notice_impossible: false, without_notice_impossible_details: nil)
    content.details.set details
    if possible_frustrate
      content.possible_frustrate_yes.click
      content.possible_frustrate_details.set possible_frustrate_details
    else
      content.possible_frustrate_no.click
    end

    if without_notice_impossible
      content.without_notice_impossible_yes.click
      content.without_notice_impossible_details.set without_notice_impossible_details
    else
      content.without_notice_impossible_no.click
    end

    content.continue_button.click
  end
end