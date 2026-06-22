class AbuseConcernsPsychologicalDetailsPage < SafetyConcernDetailsPage
  set_url '/steps/abuse_concerns/details/children/psychological'

  section :content, '#main-content' do
    element :header, 'h1', text: 'About the children’s psychological abuse'
  end
end
