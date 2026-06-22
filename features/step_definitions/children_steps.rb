When(/^I submit the details for a "(\d+)" year old child$/) do |age|
  expect(children_names_page).to be_fully_loaded
  children_names_page.add_child('John', 'Smith Jr')

  expect(child_personal_details_page).to be_fully_loaded
  child_personal_details_page.submit_child_personal_details(
    gender: 'male',
    age: age
  )

  expect(child_orders_page).to be_fully_loaded
  child_orders_page.submit_all_child_orders

  expect(special_guardianship_page).to be_fully_loaded
  special_guardianship_page.submit_no
end

Then(/^I submit the details for a "(\d+)" year old child with a special guardianship order$/) do |age|
  expect(children_names_page).to be_fully_loaded
  children_names_page.add_child('Alistair', 'Doe')

  expect(child_personal_details_page).to be_fully_loaded
  child_personal_details_page.submit_child_personal_details(
    gender: 'male',
    age: age
  )

  expect(child_orders_page).to be_fully_loaded
  child_orders_page.submit_all_child_orders

  expect(special_guardianship_page).to be_fully_loaded
  special_guardianship_page.submit_yes
end

And(/^I enter details for another child who is "(.*)" years old$/) do |age|
  expect(other_children_names_page).to be_fully_loaded
  other_children_names_page.add_child('Jane', 'Smith')

  expect(other_children_personal_details_page).to be_fully_loaded
  other_children_personal_details_page.submit_child_personal_details(
    gender: 'female',
    age: age
  )
end

Then(/^I submit that the "(.*)" has parental responsibility for the child$/) do |persons|
  expect(parental_responsibility_page).to be_fully_loaded
  parental_responsibility_page.submit_responsibility(persons)
end

And(/^I submit that the children have a child protection plan and are known to social services: "(.*)"$/) do |details|
  expect(child_additional_details_page).to be_fully_loaded
  child_additional_details_page.submit_known_to_social_services(additional_details: details)
end

And(/^I submit that I don't know any additional details for the child$/) do
  expect(child_additional_details_page).to be_fully_loaded
  child_additional_details_page.submit_dont_know_to_both
end

And(/^I submit that I "(do|don't)" have other children$/) do |arg|
  answer = arg == 'do'

  expect(has_other_children_page).to be_fully_loaded
  has_other_children_page.submit(answer)
end

When(/^I submit the child lives with "(.*)"$/) do |person|
  expect(child_residence_page).to be_fully_loaded
  child_residence_page.submit_residence(person)
end

Then(/^I should be taken to the children details page$/) do
  expect(children_names_page).to be_fully_loaded
end

Then(/^I should be taken to the child residence details page$/) do
  expect(child_residence_page).to be_fully_loaded
end
