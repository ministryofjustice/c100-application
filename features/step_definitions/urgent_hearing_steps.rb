And(/^I am not asking for an urgent or without notice hearing$/) do
  expect(urgent_hearing_page).to be_displayed
  urgent_hearing_page.submit_no

  expect(without_notice_page).to be_displayed
  without_notice_page.submit_no
end

When(/^I submit that I "(do|don't)" require an urgent and without notice hearing$/) do |arg|
  expect(urgent_hearing_page).to be_displayed
  if arg == 'do'
    urgent_hearing_page.submit_yes
    
    expect(urgent_hearing_details_page).to be_displayed
    urgent_hearing_details_page.submit(
      details: 'Alistair is in grave danger because of Jake Gyllenhaal',
      hearing_when: 'In the next four weeks',
      urgent: false
    )
  else
    urgent_hearing_page.submit_no
  end

  expect(without_notice_page).to be_displayed
  if arg == 'do'
    without_notice_page.submit_yes
    without_notice_details_page.submit(
      details: 'Alistair is in grave danger because of Jake Gyllenhaal and I need to rescue him',
      possible_frustrate: false,
      without_notice_impossible: false
    )
  else
    without_notice_page.submit_no
  end
end

Then(/^I should be taken to the urgent hearing page$/) do
  expect(urgent_hearing_page).to be_displayed
end