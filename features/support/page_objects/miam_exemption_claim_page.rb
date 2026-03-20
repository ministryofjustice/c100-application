class MiamExemptionClaimPage < YesNoPage
  set_url '/steps/miam/exemption_claim'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Do you have a valid reason for not attending a MIAM?'
  end
end