class ApplicantRefugePage < BasePage
  set_url '/steps/applicant/refuge'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Are you currently resident in a refuge?'
    element :answer_yes, "input#steps-applicant-refuge-form-refuge-yes-field", visible: false
    element :answer_no, "input#steps-applicant-refuge-form-refuge-no-field", visible: false
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
