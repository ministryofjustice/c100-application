class HasOtherChildrenPage < YesNoPage
  set_url '/steps/children/has_other_children'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Do you or any respondents have other children who are not part of this application?'
  end
end