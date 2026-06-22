class OtherChildrenNamesPage < BasePage
  set_url '/steps/other_children/names'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Enter the names of the children'
    element :first_name_field, "input[name='steps_other_children_names_split_form[new_first_name]']"
    element :last_name_field, "input[name='steps_other_children_names_split_form[new_last_name]']"
  end

  def add_child(first_name, last_name)
    content.first_name_field.set first_name
    content.last_name_field.set last_name
    click_continue_button
  end
end
