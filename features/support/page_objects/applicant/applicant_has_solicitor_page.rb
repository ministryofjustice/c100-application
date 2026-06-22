class ApplicantHasSolicitorPage < BasePage
  set_url '/steps/applicant/has_solicitor'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Will you be legally represented by a solicitor in these proceedings?'
    element :answer_yes, "input#steps-applicant-has-solicitor-form-has-solicitor-yes-field", visible: false
    element :answer_no, "input#steps-applicant-has-solicitor-form-has-solicitor-no-field", visible: false
  end

  def submit_yes
    content.answer_yes.click
    click_continue_button
  end

  def submit_no
    content.answer_no.click
    click_continue_button
  end

  def submit(answer)
    if answer == 'yes'
      submit_yes
    else
      submit_no
    end
  end
end
