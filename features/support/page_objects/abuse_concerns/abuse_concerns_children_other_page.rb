class AbuseConcernsChildrenOtherPage < YesNoPage
  set_url '/steps/abuse_concerns/question/children/other'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Do you have any other safety or welfare concerns about the children?'
  end
end