class OtherPartyRefugePage < YesNoPage
  set_url_matcher %r{/steps/other_party/refuge/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'resident in a refuge'
    element :dont_know, "input[name='steps_other_party_refuge_form[refuge]'][value='unknown']", visible: false
  end

  def dont_know
    content.dont_know.click
    click_continue_button
  end
end
