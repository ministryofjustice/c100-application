class SomethingWrongPage < BasePage
  set_url '/steps/opening/error_but_continue'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Something went wrong'
    element :p1, 'p', text: 'Although the postcode you entered looks like it’s in the right format, our checker didn’t recognise it. This can happen sometimes if it’s a very new or old postcode.'
    element :subtitle, 'h2', text: 'What to do now'
    element :p2, 'p', text: 'You can go back and try again, or download the C100 paper form to print and fill in offline. You can then submit the completed form by post or in person at the court.'
  end

end

