class UrgentHearingDetailsPage < BasePage
  set_url '/steps/application/urgent_hearing_details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Details of urgent hearing'
    element :details, 'textarea[name="steps_application_urgent_hearing_details_form[urgent_hearing_details]"]'
    element :hearing_when, 'input[name="steps_application_urgent_hearing_details_form[urgent_hearing_when]"]'
    element :urgent_yes, 'input[name="steps_application_urgent_hearing_details_form[urgent_hearing_short_notice]"][value="yes"]', visible: false
    element :urgent_no, 'input[name="steps_application_urgent_hearing_details_form[urgent_hearing_short_notice]"][value="no"]', visible: false
    element :continue_button, 'button', text: 'Continue'
  end

  def submit(details:, hearing_when:, urgent: false)
    content.details.set details
    content.hearing_when.set hearing_when
    if urgent
      content.urgent_yes.click
    else
      content.urgent_no.click
    end
    content.continue_button.click
  end
end