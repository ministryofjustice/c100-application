class ExemptionReasonsPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/miam_exemptions/exemption_reasons'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Evidence of MIAM exemption'
    element :legend, 'h1', text: 'Are you able to attach the required evidence to support a MIAM exemption claim?'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'

    element :continue_button, 'button', text: 'Continue'
  end
end
