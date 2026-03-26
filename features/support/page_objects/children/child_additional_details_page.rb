class ChildAdditionalDetailsPage < BasePage
  set_url '/steps/children/additional_details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Further information'
    section :known_to_social_services, '.govuk-form-group', text: 'Are any of the children known to social services?' do
      element :yes, "input#steps-children-additional-details-form-children-known-to-authorities-yes-field", visible: false
      element :no, "input#steps-children-additional-details-form-children-known-to-authorities-no-field", visible: false
      element :dont_know, "input#steps-children-additional-details-form-children-known-to-authorities-unknown-field", visible: false
    end   
    section :child_protection_plan, '.govuk-form-group', text: 'Are any of the children the subject of a child protection plan?' do
      element :yes, "input#steps-children-additional-details-form-children-protection-plan-yes-field", visible: false
      element :no, "input#steps-children-additional-details-form-children-protection-plan-no-field", visible: false
      element :dont_know, "input#steps-children-additional-details-form-children-protection-plan-unknown-field", visible: false
    end   
    element :continue_button, "button", text: "Continue"
  end

  def submit_dont_know_to_both
    content.known_to_social_services.dont_know.click
    content.child_protection_plan.dont_know.click
    content.continue_button.click
  end
end