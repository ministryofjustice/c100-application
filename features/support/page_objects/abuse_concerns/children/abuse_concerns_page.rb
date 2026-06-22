class AbuseConcernsPage < BasePage
  set_url '/steps/abuse_concerns/start'

  section :content, '#main-content' do
    element :header, 'h1', text: 'You and the children'
  end
end
