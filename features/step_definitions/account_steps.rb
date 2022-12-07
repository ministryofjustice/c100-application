Given("I am on safety concern page") do
  choose('Consent order', visible: :all)
  click_button "Continue"
  expect(page).to have_text "Upload the draft of your consent order"
  attach_file(Rails.root + 'features/support/sample_file/image.jpg')
  click_button "Continue"
  expect(page).to have_text "You do not have to attend a MIAM"
  click_link("Continue")
  expect(page).to have_text "Does this application concern a child who is the subject of separate ongoing emergency proceedings, care proceedings or supervision proceedings (or is already the subject of an emergency, care or supervision order)?"
  choose('No', visible: :all)
  click_button "Continue"
  expect(page).to have_text "Safety concerns"
  click_link("Continue")
  expect(page).to have_text "Are the children at risk of being abducted?"
end

Then("I create an account") do
  click_button "Save and come back later"
  expect(page).to have_text "Save your application"
  fill_in "Your email address", with: "email#{rand(100)}@test.com"
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