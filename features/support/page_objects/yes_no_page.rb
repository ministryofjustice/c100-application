class YesNoPage < BasePage
  section :selection_area, '#main-content' do
    element :answer_yes, "input[value='yes']", visible: false
    element :answer_no, "input[value='no']", visible: false
  end

  def submit_yes
    selection_area.answer_yes.click
    click_continue_button
  end

  def submit_no
    selection_area.answer_no.click
    click_continue_button
  end

  def submit(answer)
    case answer
    when true, 'yes'
      submit_yes
    else
      submit_no
    end
  end
end
