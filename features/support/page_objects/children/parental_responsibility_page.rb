class ParentalResponsibilityPage < BasePage
  set_url_matcher %r{/steps/children/parental_responsibility/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'Parental responsibility for'
    element :responsiblity_field, "input#steps-children-parental-responsibility-form-parental-responsibility-field"
  end

  def submit_responsibility(answer)
    content.responsiblity_field.set answer
    click_continue_button
  end
end
