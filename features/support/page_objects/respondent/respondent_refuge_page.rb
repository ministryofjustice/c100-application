class RespondentRefugePage < YesNoPage
 set_url_matcher %r{/steps/respondent/refuge/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'currently resident in a refuge?'
  end
end