Given("I am on safety concern page") do
  step_conset_order
  upload_file
  step_no_need_miam
  step_no_emergency
  step_safety_concern
  step_abducted

rescue Selenium::WebDriver::Error::UnknownError => e
  puts 'failed safety concern'
end

def step_abducted
  find(:xpath, './/main', visible: true, wait: true)
  expect(page).to have_text "Are the children at risk of being abducted?"
end

def step_no_emergency
  find(:xpath, './/main', visible: true, wait: true)
  expect(page).to have_text "Does this application concern a child who is the subject of separate ongoing emergency proceedings, care proceedings or supervision proceedings (or is already the subject of an emergency, care or supervision order)?"
  choose('No', visible: :all)
  click_button("Continue", wait: true)
end

def step_conset_order
  find(:xpath, './/main', visible: true, wait: true)
  expect(page).to have_text 'What kind of application do you want to make?'
  choose('Consent order', visible: :all)
  click_button "Continue"
end

def step_no_need_miam
  find(:xpath, './/main', visible: true, wait: true)
  expect(page).to have_text "You do not have to attend a MIAM"
  click_link("Continue")
end

def step_safety_concern
  find(:xpath, './/main', visible: true, wait: true)
  expect(page).to have_text "Safety concerns"
  click_link("Continue", wait: true)
rescue Selenium::WebDriver::Error::UnknownError => e
  find(:xpath, './/main', visible: true, wait: true)
  expect(page).to have_text "Safety concerns"
  click_link("Continue", wait: true)
end

def upload_file
  find(:xpath, './/main', visible: true, wait: true)
  expect(page).to have_text "Upload the draft of your consent order"
  file_input = find('input[type="file"]', visible: false)
  file_input.attach_file(Rails.root.join('features/support/sample_file/image.jpg'))
  click_button "Continue"
end

Then("I create an account") do
  find(:xpath, './/main', visible: true, wait: true)
  click_button "Save and come back later"
  expect(page).to have_text "Save your application"
  fill_in "Your email address", with: "#{rand(1000)}email#{rand(1000)}@test.com"
  fill_in "Create a password", with: 'password123456'
  click_button "Create account"
end

Then("I create an account to login") do
  find(:xpath, './/main', visible: true, wait: true)
  click_button "Save and come back later"
  expect(page).to have_text "Save your application"
  fill_in "Your email address", with: "email@test.com"
  fill_in "Create a password", with: 'password123456'
  click_button "Create account"
end

Then("I login") do
  find(:xpath, './/main', visible: true, wait: true)
  fill_in "Your email address", with: "email@test.com"
  fill_in "Enter your password", with: 'password123456'
  click_button "Continue"
end

When(/^I fail to create an account$/) do
  find(:xpath, './/main', visible: true, wait: true)
  click_button "Save and come back later"
  expect(page).to have_text "Save your application"
  click_button "Create account"
end