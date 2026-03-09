class PetitionOrdersPage < BasePage
  set_url '/steps/petition/orders'

  section :content, '#main-content' do
    element :header, 'h1', text: 'What are you asking the court to decide about the children involved?'
    element :child_arrangements_home, 'input[name="steps_petition_orders_form[orders][]"][value="child_arrangements_home"]'
    element :child_arrangements_time, 'input[name="steps_petition_orders_form[orders][]"][value="child_arrangements_time"]'
    element :group_prohibited_steps, 'input[name="steps_petition_orders_form[orders][]"][value="group_prohibited_steps"]'
    element :prohibited_steps_names, 'input[name="steps_petition_orders_form[orders_collection][]"][value="prohibited_steps_names"]'
    element :prohibited_steps_medical, 'input[name="steps_petition_orders_form[orders_collection][]"][value="prohibited_steps_medical"]'
    element :prohibited_steps_holiday, 'input[name="steps_petition_orders_form[orders_collection][]"][value="prohibited_steps_holiday"]'
    element :prohibited_steps_moving, 'input[name="steps_petition_orders_form[orders_collection][]"][value="prohibited_steps_moving"]'
    element :prohibited_steps_moving_abroad, 'input[name="steps_petition_orders_form[orders_collection][]"][value="prohibited_steps_moving_abroad"]'
    element :group_specific_issues, 'input[name="steps_petition_orders_form[orders][]"][value="group_specific_issues"]'
    element :specific_issues_holiday, 'input[name="steps_petition_orders_form[orders_collection][]"][value="specific_issues_holiday"]'
    element :specific_issues_school, 'input[name="steps_petition_orders_form[orders_collection][]"][value="specific_issues_school"]'
    element :specific_issues_religion, 'input[name="steps_petition_orders_form[orders_collection][]"][value="specific_issues_religion"]'
    element :specific_issues_names, 'input[name="steps_petition_orders_form[orders_collection][]"][value="specific_issues_names"]'
    element :specific_issues_medical, 'input[name="steps_petition_orders_form[orders_collection][]"][value="specific_issues_medical"]'
    element :specific_issues_moving, 'input[name="steps_petition_orders_form[orders_collection][]"][value="specific_issues_moving"]'
    element :specific_issues_moving_abroad, 'input[name="steps_petition_orders_form[orders_collection][]"][value="specific_issues_moving_abroad"]'
    element :specific_issues_child_return, 'input[name="steps_petition_orders_form[orders_collection][]"][value="specific_issues_child_return"]'
    element :continue_button, "button", text: "Continue"
  end

  def select_issue_home
    content.child_arrangements_home.click
    content.continue_button.click
  end

  def select_issue_time
    content.child_arrangements_time.click
    content.continue_button.click
  end

  def select_issue_prohibited_steps(
    names: false,
    medical: false,
    holiday: false,
    moving: false,
    moving_abroad: false
  )
    content.group_prohibited_steps.click if names || medical || holiday || moving || moving_abroad
    content.prohibited_steps_names.click if names
    content.prohibited_steps_medical.click if medical
    content.prohibited_steps_holiday.click if holiday
    content.prohibited_steps_moving.click if moving
    content.prohibited_steps_moving_abroad.click if moving_abroad
  end

  def select_issue_specific_issues(
    holiday: false,
    school: false,
    religion: false,
    names: false,
    medical: false,
    moving: false,
    moving_abroad: false,
    child_return: false
  )
    content.group_specific_issues.click if holiday || school || religion || names || medical || moving || moving_abroad || child_return
    content.specific_issues_holiday.click if holiday
    content.specific_issues_school.click if school
    content.specific_issues_religion.click if religion
    content.specific_issues_names.click if names
    content.specific_issues_medical.click if medical
    content.specific_issues_moving.click if moving
    content.specific_issues_moving_abroad.click if moving_abroad
    content.specific_issues_child_return.click if child_return
  end

  def submit
    content.continue_button.click
  end
end