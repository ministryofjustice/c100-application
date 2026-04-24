class AbductionPreviousAttemptDetailsPage < BasePage
  set_url '/steps/abduction/previous_attempt_details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Provide details of the previous abductions'
    element :previous_attempt_details, '#steps-abduction-previous-attempt-details-form-previous-attempt-details-field'
    element :agency_involved_yes, '#steps-abduction-previous-attempt-details-form-previous-attempt-agency-involved-yes-field'
    element :agency_involved_no, '#steps-abduction-previous-attempt-details-form-previous-attempt-agency-involved-no-field'
    element :agency_details, '#steps-abduction-previous-attempt-details-form-previous-attempt-agency-details-field'
    element :continue_button, "button", text: "Continue"
  end

  def submit_no_agency_involved
    content.previous_attempt_details.set 'Previous attempt details'
    content.agency_involved_no.click
    content.continue_button.click
  end

  def submit_agency_involved
    content.previous_attempt_details.set 'Previous attempt details'
    content.agency_involved_yes.click
    content.agency_details.set 'Agency details'
    content.continue_button.click
  end
end