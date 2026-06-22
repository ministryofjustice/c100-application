class AlternativeCourtPage < BasePage
  set_url '/steps/alternatives/court'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Going to court'
    element :acknowledgement, 'input#steps-alternatives-court-form-court-acknowledgement-true-field', visible: false
  end

  def acknowledge_and_continue
    content.acknowledgement.click
    click_continue_button
  end
end
