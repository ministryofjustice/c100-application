class SafetyConcernDetailsPage < BasePage
  section :content, '#main-content' do
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
    content.concern_details.set(concern_details)
    content.behaviour_start.set(behaviour_start)

    if behaviour_stop
      content.behaviour_ongoing_no.click
      content.behaviour_stop.set(behaviour_stop)
    else
      content.behaviour_ongoing_yes.click
    end

    if asked_for_help
      content.asked_for_help_yes.click
      content.help_party.set(help_party)
      content.help_description.set(help_description)
      if help_provided
        content.help_provided_yes.click
      else
        content.help_provided_no.click
      end
    else
      content.asked_for_help_no.click
    end

    content.continue_button.click
  end
end
