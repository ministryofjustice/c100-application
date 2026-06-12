class YesNoPage < BasePage
  section :selection_area, '#main-content' do
    element :answer_yes, "input[value='yes']", visible: false
    element :answer_no, "input[value='no']", visible: false
    element :continue_button, "button", text: "Continue"
  end

  def submit_yes
    selection_area.answer_yes.click
    selection_area.continue_button.click
  end

  def submit_no
    selection_area.answer_no.click
    selection_area.continue_button.click
  end
  
  def submit(answer)
    if answer == 'yes'
      submit_yes
    else
      submit_no
    end
  end
end