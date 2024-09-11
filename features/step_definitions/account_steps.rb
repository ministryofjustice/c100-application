Given("I am on safety concern page") do
  expect(page).to have_text 'What kind of application do you want to make?'
  choose('Consent order', visible: :all)
  click_button "Continue"
  upload_file
  expect(page).to have_text "You do not have to attend a MIAM"
  click_link("Continue")
  expect(page).to have_text "Does this application concern a child who is the subject of separate ongoing emergency proceedings, care proceedings or supervision proceedings (or is already the subject of an emergency, care or supervision order)?"
  choose('No', visible: :all)
  click_button("Continue", wait: true)
  step_safety_concern
  expect(page).to have_text "Are the children at risk of being abducted?"
rescue Selenium::WebDriver::Error::UnknownError => e
  puts 'failed safety concern'
end

def step_safety_concern
  find(:xpath, './/main', visible: true, wait: 5)
  expect(page).to have_text "Safety concerns"
  click_link("Continue", wait: true)
rescue Selenium::WebDriver::Error::UnknownError => e
  find(:xpath, './/main', visible: true, wait: 5)
  expect(page).to have_text "Safety concerns"
  click_link("Continue", wait: true)
end

def upload_file
  find(:xpath, './/main', visible: true, wait: 5)
  expect(page).to have_text "Upload the draft of your consent order"
  attach_file(Rails.root + 'features/support/sample_file/image.jpg')
  click_button "Continue"
end

Then("I create an account") do
  click_button "Save and come back later"
  expect(page).to have_text "Save your application"
  fill_in "Your email address", with: "#{rand(1000)}email#{rand(1000)}@test.com"
  fill_in "Create a password", with: 'password123456'
  click_button "Create account"
end

Then("I create an account to login") do
  click_button "Save and come back later"
  expect(page).to have_text "Save your application"
  fill_in "Your email address", with: "email@test.com"
  fill_in "Create a password", with: 'password123456'
  click_button "Create account"
end

Then("I login") do
  fill_in "Your email address", with: "email@test.com"
  fill_in "Enter your password", with: 'password123456'
  click_button "Continue"
end

When(/^I fail to create an account$/) do
  click_button "Save and come back later"
  expect(page).to have_text "Save your application"
  click_button "Create account"
end