class MiamAcknowledgementPage < BasePage
  set_url '/steps/miam/acknowledgement'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Attending a Mediation Information and Assessment Meeting (MIAM)'
    element :voucher_scheme_yes, 'input[name="steps_miam_acknowledgement_form[mediation_voucher_scheme]"][value="yes"]', visible: false
    element :voucher_scheme_no, 'input[name="steps_miam_acknowledgement_form[mediation_voucher_scheme]"][value="no"]', visible: false
    element :miam_acknowledgement, 'input[name="steps_miam_acknowledgement_form[miam_acknowledgement]"]', visible: false
    element :continue_button, "button", text: "Continue"
  end

  def submit_voucher_scheme_yes
    content.voucher_scheme_yes.click
    content.miam_acknowledgement.click
    content.continue_button.click
  end

  def submit_voucher_scheme_no
    content.voucher_scheme_no.click
    content.miam_acknowledgement.click
    content.continue_button.click
  end
end