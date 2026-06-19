And(/^I am not asking for an urgent or without notice hearing$/) do
  expect(urgent_hearing_page).to be_displayed
  urgent_hearing_page.submit_no

  expect(without_notice_page).to be_displayed
  without_notice_page.submit_no
end

When(/^I submit that I "(do|don't)" require an urgent hearing$/) do |arg|
  expect(urgent_hearing_page).to be_displayed

  if arg == "don't"
    urgent_hearing_page.submit_no
    next
  end
  
  urgent_hearing_page.submit_yes

  expect(urgent_hearing_details_page).to be_displayed
  urgent_hearing_details_page.submit(
    details: 'Alistair is in grave danger because of Jake Gyllenhaal',
    hearing_when: 'In the next four weeks',
    urgent: false
  )
end

And(/^I submit that I "(do|don't)" require a without notice hearing$/) do |arg|
  expect(without_notice_page).to be_displayed

  if arg == "don't"
    without_notice_page.submit_no
    next
  end

  without_notice_page.submit_yes

  expect(without_notice_details_page).to be_displayed
  without_notice_details_page.submit(
    details: 'Alistair is in grave danger because of Jake Gyllenhaal and I need to rescue him',
    possible_frustrate: false,
    without_notice_impossible: false
  )
end

Then(/^I should be taken to the urgent hearing page$/) do
  expect(urgent_hearing_page).to be_displayed
end
