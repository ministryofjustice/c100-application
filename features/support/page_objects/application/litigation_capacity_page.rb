class LitigationCapacityPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/application/litigation_capacity'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Are there any factors that may affect any adult in this application taking part in the court proceedings?'
    element :p, 'p', text: 'For example, they may lack the capacity to conduct legal proceedings, or suffer from a mental or physical impairment or other health problem'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'

    element :continue_button, 'button', text: 'Continue'
  end
end
