class AbuseConcernsChildrenInfoPage < BasePage
  set_url '/steps/abuse_concerns/children_info'

  section :content, '#main-content' do
    element :header, 'h1', text: 'The children’s safety'
  end
end
