class ParentalResponsibilityPage < BasePage
  set_url_matcher %r{/steps/children/parental_responsibility/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'Is there a Special Guardianship Order in force in relation to'
    element :responsiblity_field, "input#steps-children-parental-responsibility-form-parental-responsibility-field"
    element :continue_button, "button", text: "Continue"
  end

  def submit_responsibility(answer)
    content.responsiblity_field.set answer
    content.continue_button.click
  end
end