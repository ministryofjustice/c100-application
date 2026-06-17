class ExistingCourtOrderPage < YesNoPage
  set_url '/steps/application/existing_court_order'

  section :content, '#main-content' do
    element :header, 'h1',
            text: 'Is there an order under section 91(14) Children Act 1989, a limited civil restraint order, a general civil restraint order or an extended civil restraint order in force which means you need permission to make this application?'
    element :case_number, 'input[name="steps_application_existing_court_order_form[court_order_case_number]"]'
    element :day, 'input[name="steps_application_existing_court_order_form[court_order_expiry_date(3i)]"]'
    element :month, 'input[name="steps_application_existing_court_order_form[court_order_expiry_date(2i)]"]'
    element :year, 'input[name="steps_application_existing_court_order_form[court_order_expiry_date(1i)]"]'
  end

  def submit_yes(case_number, expiry_date)
    parsed_date = Date.parse(expiry_date)
    selection_area.answer_yes.click
    content.case_number.set(case_number)
    content.day.set(parsed_date.day)
    content.month.set(parsed_date.month)
    content.year.set(parsed_date.year)
    selection_area.continue_button.click
  end
end
