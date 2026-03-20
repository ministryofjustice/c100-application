class AttendingCourtLanguagePage < BasePage
 set_url '/steps/attending_court/language'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Does anyone in this application have special language requirements?'
    element :language_interpreter, 'input[id="steps-attending-court-language-form-language-options-language-interpreter-field"]', visible: false
    element :language_interpreter_details, 'textarea[name="steps_attending_court_language_form[language_interpreter_details]"]'
    element :sign_language_interpreter, 'input[id="steps-attending-court-language-form-language-options-sign-language-interpreter-field"]', visible: false
    element :sign_language_interpreter_details, 'textarea[name="steps_attending_court_language_form[sign_language_interpreter_details]"]'
    element :welsh_language, 'input[id="steps-attending-court-language-form-language-options-welsh-language-field"]', visible: false
    element :welsh_language_details, 'textarea[name="steps_attending_court_language_form[welsh_language_details]"]'
    element :continue_button, "button", text: "Continue"
  end

  def submit_language_requirements(language_interpreter_details: nil, sign_language_interpreter_details: nil, welsh_language_details: nil)
    content.language_interpreter.click if language_interpreter_details
    content.language_interpreter_details.set(language_interpreter_details) if language_interpreter_details

    content.sign_language_interpreter.click if sign_language_interpreter_details
    content.sign_language_interpreter_details.set(sign_language_interpreter_details) if sign_language_interpreter_details

    content.welsh_language.click if welsh_language_details
    content.welsh_language_details.set(welsh_language_details) if welsh_language_details

    content.continue_button.click
  end

  def continue_without_filling
    content.continue_button.click
  end
end