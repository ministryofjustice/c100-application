class AbuseConcernsEmotionalDetailsPage < SafetyConcernDetailsPage
  set_url '/steps/abuse_concerns/details/children/emotional'

  section :content, '#main-content' do
    element :header, 'h1', text: 'About the children’s emotional abuse'
  end
end
