When(/^I ask the court to decide on the following issues: "(.*)"$/) do |issues|
  expect(petition_orders_page).to be_displayed

  petition_orders_page.select_issue_home if issues.include?('who the children live with and when')
  petition_orders_page.select_issue_time if issues.include?('how much time they spend with each person')

  petition_orders_page.select_issue_specific_issues(
    holiday: issues.include?('a specific holiday or arrangement'),
    school: issues.include?('what school they’ll go to'),
    religion: issues.include?('a religious issue'),
    names: issues.include?('changing their names or surname'),
    medical: issues.include?('medical treatment'),
    moving: issues.include?('relocating the children to a different area in england and wales'),
    moving_abroad: issues.include?('relocating the children outside of england and wales'),
    child_return: issues.include?('returning the children to your care')
  )

  petition_orders_page.submit
end

Then(/^I should see the child arrangements order details for: "(.*)"$/) do |issue|
  expect(petition_playback_page).to be_displayed
  if issue.include?('who the children live with and when')
    expect(petition_playback_page.content.child_arrangements_home).to be_visible
  end
  if issue.include?('how much time they spend with each person')
    expect(petition_playback_page.content.child_arrangements_time).to be_visible
  end
  expect(petition_playback_page.content.child_arrangements_order).to be_visible
end

Then(/^I should see the specific issue order details for: "([^"]*)"$/) do |issues|
  selected_issues = issues.split(',').map(&:strip)

  expect(petition_playback_page).to be_displayed
  selected_issues.each do |issue|
    case issue
    when 'a specific holiday or arrangement'
      expect(petition_playback_page.content.specific_issues_holiday).to be_visible
    when 'what school they’ll go to'
      expect(petition_playback_page.content.specific_issues_school).to be_visible
    when 'a religious issue'
      expect(petition_playback_page.content.specific_issues_religion).to be_visible
    when 'changing their names or surname'
      expect(petition_playback_page.content.specific_issues_names).to be_visible
    when 'medical treatment'
      expect(petition_playback_page.content.specific_issues_medical).to be_visible
    when 'relocating the children to a different area in england and wales'
      expect(petition_playback_page.content.specific_issues_moving).to be_visible
    when 'relocating the children outside of england and wales'
      expect(petition_playback_page.content.specific_issues_moving_abroad).to be_visible
    when 'returning the children to your care'
      expect(petition_playback_page.content.specific_issues_child_return).to be_visible
    else
      raise ArgumentError, "Unknown specific issue: '#{issue}'"
    end
  end
end

And(/^I continue to the next step$/) do
  petition_playback_page.continue_to_next_step
end

When(/^I submit that I want the court to also decide "(.*)"$/) do |decision|
  expect(petition_protection_page).to be_displayed
  petition_protection_page.submit_yes(details: decision)
end

When(/^I submit that I am not asking the court to decide on any other issues$/) do
  expect(petition_protection_page).to be_displayed
  petition_protection_page.submit_no
end

Then(/^I should be taken to the petition orders page$/) do
  expect(petition_orders_page).to be_displayed
end

Then(/^I should be taken to the petition protection page$/) do
  expect(petition_protection_page).to be_displayed
end
