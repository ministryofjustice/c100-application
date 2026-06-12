class SafetyConcernDetailsPage < BasePage
  section :concern_content, '#main-content' do
    element :concern_details, "textarea[name='steps_abuse_concerns_details_form[behaviour_description]']"
    element :behaviour_start, "input[name='steps_abuse_concerns_details_form[behaviour_start]']"
    element :behaviour_ongoing_yes, "input[name='steps_abuse_concerns_details_form[behaviour_ongoing]'][value='yes']"
    element :behaviour_ongoing_no, "input[name='steps_abuse_concerns_details_form[behaviour_ongoing]'][value='no']", visible: false
    element :behaviour_stop, "input[name='steps_abuse_concerns_details_form[behaviour_stop]']", visible: false
    element :asked_for_help_yes, "input[name='steps_abuse_concerns_details_form[asked_for_help]'][value='yes']"
    element :asked_for_help_no, "input[name='steps_abuse_concerns_details_form[asked_for_help]'][value='no']", visible: false
    element :help_party, "input[name='steps_abuse_concerns_details_form[help_party]']"
    element :help_provided_yes, "input[name='steps_abuse_concerns_details_form[help_provided]'][value='yes']"
    element :help_provided_no, "input[name='steps_abuse_concerns_details_form[help_provided]'][value='no']", visible: false
    element :help_description, "textarea[name='steps_abuse_concerns_details_form[help_description]']"
    element :continue_button, "button", text: "Continue"
  end

  def submit_concern_details(
    concern_details:,
    behaviour_start:,
    behaviour_stop: nil,
    asked_for_help:,
    help_party: nil,
    help_provided: nil,
    help_description: nil
  )
    concern_content.concern_details.set(concern_details)
    concern_content.behaviour_start.set(behaviour_start)

    if behaviour_stop
      concern_content.behaviour_ongoing_no.click
      concern_content.behaviour_stop.set(behaviour_stop)
    else
      concern_content.behaviour_ongoing_yes.click
    end

    if asked_for_help
      concern_content.asked_for_help_yes.click
      concern_content.help_party.set(help_party)
      concern_content.help_description.set(help_description)
      if help_provided
        concern_content.help_provided_yes.click
      else
        concern_content.help_provided_no.click
      end
    else
      concern_content.asked_for_help_no.click
    end

    concern_content.continue_button.click
  end
end
