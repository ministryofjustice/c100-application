class ChildResidencePage < BasePage
 set_url_matcher %r{/steps/children/residence/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'Address of'
    element :continue_button, "button", text: "Continue"
  end

  def submit_residence(person_name)
    check(person_name, allow_label_click: true)
    content.continue_button.click
  end
end