class ChildResidencePage < BasePage
  set_url_matcher %r{/steps/children/residence/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'Address of'
  end

  def submit_residence(person_name)
    check(person_name, allow_label_click: true)
    click_continue_button
  end
end
