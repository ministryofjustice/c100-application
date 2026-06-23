When(/^I submit that there "(has|hasn't)" been any court proceedings about the children$/) do |arg|
  answer = arg == 'has'
  previous_proceedings_page.submit(answer)
end

When(/^I submit details of previous court proceedings$/) do
  previous_proceedings_page.submit_yes

  expect(previous_court_proceedings_page).to be_displayed
  expect(previous_court_proceedings_page.content).to have_header
  previous_court_proceedings_page.submit_previous_proceedings(
    children_names: 'John Smith Jr',
    court_name: 'London Court',
    proceedings_date: '2020',
    proceedings_type: 'Legal hearing',
    details: 'Lasted for weeks'
  )
end

When(/^I submit details of previous court proceedings with an additional child$/) do
  previous_proceedings_page.submit_yes

  expect(previous_court_proceedings_page).to be_displayed
  expect(previous_court_proceedings_page.content).to have_header
  previous_court_proceedings_page.submit_previous_proceedings(
    children_names: 'Emily Doe and John Doe',
    court_name: 'Aylesbury',
    proceedings_date: 'March 2020',
    proceedings_type: 'Care order',
    details: 'Emily Doe was involved in a care order which took place at Aylesbury court'
  )
end

When(/^I submit that there "(is|isn't)" a court order requiring permission to make this application$/) do |arg|
  if arg == 'is'
    existing_court_order_page.submit_yes('12345678', '01-01-2030')

    expect(existing_court_order_uploadable_page).to be_displayed
    expect(existing_court_order_uploadable_page.content).to have_header
    existing_court_order_uploadable_page.submit_yes

    expect(existing_court_order_upload_page).to be_displayed
    expect(existing_court_order_upload_page.content).to have_header
    file_path = File.absolute_path('features/support/sample_file/image.jpg')
    existing_court_order_upload_page.upload_file(file_path)
  else
    existing_court_order_page.submit_no
  end
end

Then(/^I should be taken to the existing court order page$/) do
  expect(existing_court_order_page).to be_displayed
  expect(existing_court_order_page.content).to have_header
end

Then(/^I should be taken to the previous court proceedings page$/) do
  expect(previous_proceedings_page).to be_displayed
  expect(previous_proceedings_page.content).to have_header
end
