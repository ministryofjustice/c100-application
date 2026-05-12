class OtherPartyNamesPage < BasePage
  set_url '/steps/other_party/names'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Enter the other person’s name'
    element :first_name_field, "input[name='steps_other_party_names_split_form[new_first_name]']"
    element :last_name_field, "input[name='steps_other_party_names_split_form[new_last_name]']"
    element :continue_button, "button", text: "Continue"
  end

  def submit_names(first_name, last_name)
    content.first_name_field.set first_name
    content.last_name_field.set last_name
    content.continue_button.click
  end
end