class ChildProtectionCasePage < YesNoPage
  set_url '/steps/opening/child_protection_cases'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Does this application concern a child who is the subject of separate ongoing emergency proceedings, care proceedings or supervision proceedings (or is already the subject of an emergency, care or supervision order)?'
  end
end
