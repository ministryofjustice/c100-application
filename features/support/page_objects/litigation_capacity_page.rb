class LitigationCapacityPage < YesNoPage
  set_url '/steps/application/litigation_capacity'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Are there any factors that may affect any adult in this application taking part in the court proceedings?'
  end
end