class AlternativePage < BasePage
  set_url '/steps/alternatives/start'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Alternative ways to reach an agreement'
  end
end
