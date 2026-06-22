class AbuseConcernsFinancialDetailsPage < SafetyConcernDetailsPage
  set_url '/steps/abuse_concerns/details/children/financial'

  section :content, '#main-content' do
    element :header, 'h1', text: 'About the children’s financial abuse'
  end
end
