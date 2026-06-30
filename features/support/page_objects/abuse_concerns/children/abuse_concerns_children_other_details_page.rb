class AbuseConcernsChildrenOtherDetailsPage < SafetyConcernDetailsPage
  set_url '/steps/abuse_concerns/details/children/other'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Other concerns about the children'
  end
end
