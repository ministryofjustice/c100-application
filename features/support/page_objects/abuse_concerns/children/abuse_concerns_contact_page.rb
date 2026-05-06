class AbuseConcernsContactPage < BasePage
  set_url '/steps/abuse_concerns/contact'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Contact between the children and the other people in this application'
    element :spend_time_with_others_yes, 'input[name="steps_abuse_concerns_contact_form[concerns_contact_type]"][value="yes"]'
    element :spend_time_with_others_supervised, 'input[name="steps_abuse_concerns_contact_form[concerns_contact_type]"][value="supervised"]'
    element :spend_time_with_others_no, 'input[name="steps_abuse_concerns_contact_form[concerns_contact_type]"][value="none"]', visible: false
    element :being_in_touch_yes, 'input[name="steps_abuse_concerns_contact_form[concerns_contact_other]"][value="yes"]'
    element :being_in_touch_no, 'input[name="steps_abuse_concerns_contact_form[concerns_contact_other]"][value="no"]', visible: false
    element :continue_button, "button", text: "Continue"
  end

  def submit_contact_details(contact_type:, being_in_touch:)
    case contact_type
    when "yes"
      content.spend_time_with_others_yes.click
    when "supervised"
      content.spend_time_with_others_supervised.click
    when "no"
      content.spend_time_with_others_no.click
    end

    case being_in_touch
    when "yes"
      content.being_in_touch_yes.click
    when "no"
      content.being_in_touch_no.click
    end

    content.continue_button.click
  end
end