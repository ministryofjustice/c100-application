class BasePage < SitePrism::Page
  section :cookie, '.govuk-cookie-banner' do
    element :header, 'h2', text: 'Cookies on Apply to court about child arrangements'
    element :accept_button, "input[value='Accept analytics cookies']"
    element :reject_button, "input[value='Reject analytics cookies']"
  end

  section :content, '#content' do
    element :p, 'p'
    element :h1, 'h1'
    element :h2, 'h2'
    element :there_is_a_problem, 'h2', text: 'There is a problem'
    element :step_number, '.govuk-caption-l'
  end

end