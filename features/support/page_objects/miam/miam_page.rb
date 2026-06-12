class MiamPage < BasePage
  set_url '/steps/opening/child_protection_info'

  section :content, '#main-content' do
    element :header, 'h1', text: "MIAM"
    element :continue_link, "a.govuk-button", text: "Continue"
  end

  def continue_to_next_step
    content.continue_link.click
  end
end