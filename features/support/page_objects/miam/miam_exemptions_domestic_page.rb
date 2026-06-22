class MiamExemptionsDomesticPage < BasePage
  set_url '/steps/miam_exemptions/domestic'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Providing evidence of domestic abuse concerns'
    element :domestic_none, 'input[name="steps_miam_exemptions_domestic_form[domestic][]"][value="misc_domestic_none"]',
            visible: false
  end

  def submit_none_of_these
    content.domestic_none.click
    click_continue_button
  end
end
