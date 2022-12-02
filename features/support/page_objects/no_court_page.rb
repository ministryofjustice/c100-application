class NoCourtPage < BasePage
  set_url '/steps/opening/no_court_found'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Sorry, you cannot apply online'
    element :subtitle, 'p', text: 'This service is only available in England and Wales.'
    element :next_steps, 'h2', text: 'Download the form (PDF)'
  end

end

