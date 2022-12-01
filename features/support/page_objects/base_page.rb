class BasePage < SitePrism::Page
  section :cookie, '.govuk-cookie-banner' do
    element :header, 'h2', text: 'Cookies on Apply to court about child arrangements'
    element :accept_button, "input[value='Accept analytics cookies']"
    element :reject_button, "input[value='Reject analytics cookies']"
  end
end