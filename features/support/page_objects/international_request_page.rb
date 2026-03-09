class InternationalRequestPage < YesNoPage
  set_url '/steps/international/request'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Has a request for information or other assistance involving the children been made to or by another country?'
    element :details, 'textarea[name="steps_international_request_form[international_request_details]"]'
  end

  def submit_yes(details)
    selection_area.answer_yes.click
    content.details.set details
    selection_area.continue_button.click
  end
end